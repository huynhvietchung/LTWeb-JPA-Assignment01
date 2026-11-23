package vn.iotstar.filter;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.WriteListener;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

public class Tomcat11SiteMeshFixFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String uri = req.getRequestURI();

        // Bỏ qua các servlet trả về file nhị phân (ảnh / video stream)
        if (uri.contains("/image") || uri.contains("/media")) {
            chain.doFilter(request, response);
            return;
        }

        // 1. Hứng toàn bộ HTML do JSP con (login.jsp, home.jsp...) xuất ra
        String innerHtml = captureResponse(req, resp, chain);

        // Nếu controller gọi sendRedirect (302) hoặc không có nội dung thì dừng
        if (resp.getStatus() >= 300 && resp.getStatus() < 400) {
            return;
        }
        if (innerHtml == null || innerHtml.trim().isEmpty()) {
            return;
        }

        // 2. Xác định decorator theo cấu hình sitemesh3.xml
        String decoratorPath = (uri.endsWith("/login") || uri.endsWith("/register")
                || uri.endsWith("/verify") || uri.endsWith("/forgot-password")
                || uri.endsWith("/reset-password"))
                ? "/WEB-INF/decorators/auth.jsp"
                : "/WEB-INF/decorators/main.jsp";

        // 3. Render file decorator (main.jsp / auth.jsp) thành chuỗi HTML
        String layoutHtml = captureDecorator(req, resp, decoratorPath);

        // 4. Trích xuất <title> và <body> từ trang con ghép vào thẻ <sitemesh:write> của decorator
        String title = extractTag(innerHtml, "title");
        String body = extractTag(innerHtml, "body");
        if (body == null) body = innerHtml;

        String finalHtml = layoutHtml
                .replace("<sitemesh:write property=\"title\"/>", title != null ? title : "LTWeb JPA")
                .replace("<sitemesh:write property=\"head\"/>", "")
                .replace("<sitemesh:write property=\"body\"/>", body);

        // 5. Ghi HTML hoàn chỉnh xuống trình duyệt
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        byte[] bytes = finalHtml.getBytes(StandardCharsets.UTF_8);
        resp.setContentLength(bytes.length);
        resp.getOutputStream().write(bytes);
        resp.getOutputStream().flush();
    }

    private String captureResponse(HttpServletRequest req, HttpServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PrintWriter pw = new PrintWriter(new OutputStreamWriter(baos, StandardCharsets.UTF_8));
        ServletOutputStream sos = new ServletOutputStream() {
            @Override public void write(int b) { baos.write(b); }
            @Override public void write(byte[] b, int off, int len) { baos.write(b, off, len); }
            @Override public boolean isReady() { return true; }
            @Override public void setWriteListener(WriteListener l) {}
        };
        HttpServletResponseWrapper wrapper = new HttpServletResponseWrapper(resp) {
            @Override public PrintWriter getWriter() { return pw; }
            @Override public ServletOutputStream getOutputStream() { return sos; }
            @Override public void flushBuffer() {}
        };
        chain.doFilter(req, wrapper);
        pw.flush();
        return baos.toString(StandardCharsets.UTF_8);
    }

    private String captureDecorator(HttpServletRequest req, HttpServletResponse resp, String path)
            throws IOException, ServletException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PrintWriter pw = new PrintWriter(new OutputStreamWriter(baos, StandardCharsets.UTF_8));
        ServletOutputStream sos = new ServletOutputStream() {
            @Override public void write(int b) { baos.write(b); }
            @Override public void write(byte[] b, int off, int len) { baos.write(b, off, len); }
            @Override public boolean isReady() { return true; }
            @Override public void setWriteListener(WriteListener l) {}
        };
        HttpServletResponseWrapper wrapper = new HttpServletResponseWrapper(resp) {
            @Override public PrintWriter getWriter() { return pw; }
            @Override public ServletOutputStream getOutputStream() { return sos; }
            @Override public void flushBuffer() {}
        };
        req.getRequestDispatcher(path).include(req, wrapper);
        pw.flush();
        return baos.toString(StandardCharsets.UTF_8);
    }

    private String extractTag(String html, String tag) {
        String lower = html.toLowerCase();
        int openStart = lower.indexOf("<" + tag);
        if (openStart == -1) return null;
        int openEnd = lower.indexOf(">", openStart);
        int closeStart = lower.lastIndexOf("</" + tag + ">");
        if (openEnd == -1 || closeStart == -1 || closeStart <= openEnd) return null;
        return html.substring(openEnd + 1, closeStart);
    }
}