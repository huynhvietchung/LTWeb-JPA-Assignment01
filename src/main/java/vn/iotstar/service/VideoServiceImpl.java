package vn.iotstar.service;

import java.util.List;
import vn.iotstar.dao.IVideoDao;
import vn.iotstar.dao.VideoDaoImpl;
import vn.iotstar.entity.Video;

public class VideoServiceImpl implements IVideoService {
    private final IVideoDao videoDao = new VideoDaoImpl();

    @Override
    public void insert(Video video) { videoDao.insert(video); }

    @Override
    public void update(Video video) { videoDao.update(video); }

    @Override
    public void delete(int videoId) throws Exception { videoDao.delete(videoId); }

    @Override
    public Video findById(int videoId) { return videoDao.findById(videoId); }

    @Override
    public List<Video> findAll() { return videoDao.findAll(); }

    @Override
    public List<Video> findTop10Newest() { return videoDao.findTop10Newest(); }

    @Override
    public List<Video> findByUserId(int userId) { return videoDao.findByUserId(userId); }

    @Override
    public List<Video> findByUserIdPaginated(int userId, int page, int pageSize) {
        return videoDao.findByUserIdPaginated(userId, page, pageSize);
    }

    @Override
    public long countByUserId(int userId) { return videoDao.countByUserId(userId); }

    @Override
    public void incrementViews(int videoId) {
        Video v = videoDao.findById(videoId);
        if (v != null) {
            v.setViews(v.getViews() + 1);
            videoDao.update(v);
        }
    }
}
