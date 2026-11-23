package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Video;

public interface IVideoService {
    void insert(Video video);
    void update(Video video);
    void delete(int videoId) throws Exception;
    Video findById(int videoId);
    List<Video> findAll();
    List<Video> findTop10Newest();
    List<Video> findByUserId(int userId);
    List<Video> findByUserIdPaginated(int userId, int page, int pageSize);
    long countByUserId(int userId);
    void incrementViews(int videoId);
}
