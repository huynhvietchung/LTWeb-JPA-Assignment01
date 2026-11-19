package vn.iotstar.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;

public class Tomcat11SiteMeshFixFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String uri = req.getRequestURI();

        // Đánh dấu loại layout cho trang hiện tại để JSP tự nạp Header/Footer Bootstrap 5
        boolean isAuthPage = uri.endsWith("/login") || uri.endsWith("/register")
                || uri.endsWith("/verify") || uri.endsWith("/forgot-password")
                || uri.endsWith("/reset-password");
        req.setAttribute("isAuthLayout", isAuthPage);

        // Cho request đi thẳng qua Servlet và JSP bình thường, KHÔNG bọc ResponseWrapper gây trắng trang trên Tomcat 11
        chain.doFilter(request, response);
    }
}