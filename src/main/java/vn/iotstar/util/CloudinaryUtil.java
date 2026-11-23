package vn.iotstar.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Map;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.http.Part;

public class CloudinaryUtil {
    private static final String CLOUD_NAME = "your_cloud_name"; // Thay bằng Cloud Name của bạn
    private static final String API_KEY = "your_api_key";       // Thay bằng API Key của bạn
    private static final String API_SECRET = "your_api_secret"; // Thay bằng API Secret của bạn

    private static Cloudinary getCloudinary() {
        return new Cloudinary(ObjectUtils.asMap(
                "cloud_name", CLOUD_NAME,
                "api_key", API_KEY,
                "api_secret", API_SECRET,
                "secure", true
        ));
    }

    public static String uploadImage(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        File uploadDir = new File(Constant.DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String tempFileName = System.currentTimeMillis() + "_" + Math.abs(submittedName.hashCode()) + "_" + submittedName;
        File tempFile = new File(uploadDir, tempFileName);
        filePart.write(tempFile.getAbsolutePath());

        if (!"your_cloud_name".equals(CLOUD_NAME)) {
            try {
                Cloudinary cloudinary = getCloudinary();
                Map<?, ?> uploadResult = cloudinary.uploader().upload(tempFile,
                        ObjectUtils.asMap("folder", "ltweb_avatars"));
                tempFile.delete();
                return (String) uploadResult.get("secure_url");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return tempFileName;
    }
}
