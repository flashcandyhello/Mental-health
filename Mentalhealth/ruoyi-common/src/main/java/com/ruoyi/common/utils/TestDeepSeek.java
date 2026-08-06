import com.ruoyi.common.utils.DeepSeekUtils;

public class TestDeepSeek {
    public static void main(String[] args) {
        try {
            System.out.println("Testing DeepSeekUtils.getDailyQuote()...");
            String result = DeepSeekUtils.getDailyQuote();
            System.out.println("Result: " + result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
