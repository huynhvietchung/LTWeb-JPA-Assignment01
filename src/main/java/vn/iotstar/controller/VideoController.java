package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.service.CategoryServiceImpl;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.VideoServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.ValidationUtil;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 60)
@WebServlet(urlPatterns = { "/video", "/video/detail", "/video/add", "/video/insert",
        "/video/edit", "/video/update", "/video/delete" })
public class VideoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IVideoService videoService = new VideoServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (User) session.getAttribute("account");
        String url = req.getRequestURI();

        if (url.endsWith("/video")) {
            int page = 1;
            int pageSize = 6; // Phân trang 6 sản phẩm/trang theo yêu cầu
            String pageParam = req.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Math.max(1, Integer.parseInt(pageParam));
                } catch (NumberFormatException ignored) {}
            }

            long totalVideos = videoService.countByUserId(currentUser.getId());
            int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
            if (totalPages > 0 && page > totalPages) page = totalPages;

            List<Video> videos = videoService.findByUserIdPaginated(currentUser.getId(), page, pageSize);
            req.setAttribute("videos", videos);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalVideos", totalVideos);
            req.getRequestDispatcher("/views/video/video-list.jsp").forward(req, resp);

        } else if (url.contains("/video/detail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            videoService.incrementViews(id);
            Video video = videoService.findById(id);
            req.setAttribute("video", video);
            req.getRequestDispatcher("/views/video/video-detail.jsp").forward(req, resp);

        } else if (url.contains("/video/add")) {
            req.setAttribute("categories", categoryService.findAll());
            req.getRequestDispatcher("/views/video/video-add.jsp").forward(req, resp);

        } else if (url.contains("/video/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Video video = videoService.findById(id);
            if (video != null && video.getUser() != null && video.getUser().getId() == currentUser.getId()) {
                req.setAttribute("video", video);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/video/video-edit.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/video");
            }

        } else if (url.contains("/video/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Video video = videoService.findById(id);
            if (video != null && video.getUser() != null && video.getUser().getId() == currentUser.getId()) {
                try {
                    videoService.delete(id);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/video");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        User currentUser = (User) session.getAttribute("account");
        String url = req.getRequestURI();

        File uploadDir = new File(Constant.DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        if (url.contains("/video/insert")) {
            String title = req.getParameter("title");
            if (!ValidationUtil.isValidLength(title, 3, 255)) {
                req.setAttribute("alert", "Tiêu đề video phải từ 3 đến 255 ký tự!");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/video/video-add.jsp").forward(req, resp);
                return;
            }
            Video video = new Video();
            video.setTitle(req.getParameter("title"));
            video.setDescription(req.getParameter("description"));
            video.setActive("1".equals(req.getParameter("active")));
            video.setViews(0);
            video.setCreatedDate(new Date());
            video.setUser(currentUser);

            String cateIdStr = req.getParameter("categoryid");
            if (cateIdStr != null && !cateIdStr.isEmpty()) {
                Category cate = categoryService.findById(Integer.parseInt(cateIdStr));
                video.setCategory(cate);
            }

            // Xử lý Poster (file upload hoặc URL)
            String posterUrl = req.getParameter("poster");
            Part posterPart = req.getPart("posterFile");
            if (posterPart != null && posterPart.getSize() > 0) {
                String fname = saveFile(posterPart, Constant.DIR);
                video.setPoster(fname);
            } else if (posterUrl != null && !posterUrl.trim().isEmpty()) {
                video.setPoster(posterUrl.trim());
            } else {
                video.setPoster("https://placehold.co/640x360?text=Video+Poster");
            }

            // Xử lý Video (file mp4 upload hoặc link YouTube/URL)
            String videoLink = req.getParameter("videoUrl");
            Part videoPart = req.getPart("videoFile");
            if (videoPart != null && videoPart.getSize() > 0) {
                String vname = saveFile(videoPart, Constant.DIR);
                video.setVideoUrl(vname);
            } else if (videoLink != null && !videoLink.trim().isEmpty()) {
                video.setVideoUrl(convertToEmbedUrl(videoLink.trim()));
            }

            videoService.insert(video);
            resp.sendRedirect(req.getContextPath() + "/video");

        } else if (url.contains("/video/update")) {
            int videoId = Integer.parseInt(req.getParameter("videoId"));
            Video video = videoService.findById(videoId);
            if (video == null || video.getUser() == null || video.getUser().getId() != currentUser.getId()) {
                resp.sendRedirect(req.getContextPath() + "/video");
                return;
            }
            String title = req.getParameter("title");
            if (!ValidationUtil.isValidLength(title, 3, 255)) {
                req.setAttribute("alert", "Tiêu đề video phải từ 3 đến 255 ký tự!");
                req.setAttribute("video", video);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/video/video-edit.jsp").forward(req, resp);
                return;
            }

            video.setTitle(req.getParameter("title"));
            video.setDescription(req.getParameter("description"));
            video.setActive("1".equals(req.getParameter("active")));

            String cateIdStr = req.getParameter("categoryid");
            if (cateIdStr != null && !cateIdStr.isEmpty()) {
                video.setCategory(categoryService.findById(Integer.parseInt(cateIdStr)));
            }

            String posterUrl = req.getParameter("poster");
            Part posterPart = req.getPart("posterFile");
            if (posterPart != null && posterPart.getSize() > 0) {
                video.setPoster(saveFile(posterPart, Constant.DIR));
            } else if (posterUrl != null && !posterUrl.trim().isEmpty()) {
                video.setPoster(posterUrl.trim());
            }

            String videoLink = req.getParameter("videoUrl");
            Part videoPart = req.getPart("videoFile");
            if (videoPart != null && videoPart.getSize() > 0) {
                video.setVideoUrl(saveFile(videoPart, Constant.DIR));
            } else if (videoLink != null && !videoLink.trim().isEmpty()) {
                video.setVideoUrl(convertToEmbedUrl(videoLink.trim()));
            }

            videoService.update(video);
            resp.sendRedirect(req.getContextPath() + "/video");
        }
    }

    private String saveFile(Part part, String uploadPath) throws IOException {
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        int index = filename.lastIndexOf(".");
        String ext = index > 0 ? filename.substring(index) : "";
        String fname = System.currentTimeMillis() + "_" + Math.abs(filename.hashCode()) + ext;
        part.write(uploadPath + File.separator + fname);
        return fname;
    }

    private String convertToEmbedUrl(String url) {
        if (url.contains("youtube.com/watch?v=")) {
            String videoId = url.split("v=")[1].split("&")[0];
            return "https://www.youtube.com/embed/" + videoId;
        } else if (url.contains("youtu.be/")) {
            String videoId = url.substring(url.lastIndexOf("/") + 1).split("\\?")[0];
            return "https://www.youtube.com/embed/" + videoId;
        }
        return url;
    }
}
