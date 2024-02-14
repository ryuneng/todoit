package utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {

	private static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat DATE_FORMAT_MONTH_DAY = new SimpleDateFormat("M월 d일");
	private static SimpleDateFormat DATE_FORMAT_CUSTOM = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	/**
	 * 날짜를 전달받아서 "2024-01-04"과 같은 형식의 문자열로 반환한다.
	 * @param date 날짜
	 * @return 형식화된 문자열
	 */
	public static String toText(Date date) {
		if (date == null) {
			return "";
		}
		
		return DATE_FORMAT.format(date);
	
	}
	
	public static Date toDate(String text) throws ParseException {
		if (text == null) {
			return null;
		}
		
		return DATE_FORMAT.parse(text);
	}
	
	
	
	// 한글 버전
	private static SimpleDateFormat DATE_FORMAT_KOREAN = new SimpleDateFormat("yyyy년 MM월 dd일");
	
	/**
	 * 날짜를 전달받아서 "2024년 01월 04일"과 같은 형식의 문자열로 반환한다.
	 * @param date 날짜
	 * @return 형식화된 문자열
	 */
	public static String toTextKorean(Date date) {
		if (date == null) {
			return "";
		}
		
		return DATE_FORMAT_KOREAN.format(date);
	
	}
	
	public static Date toDateKorean(String text) throws ParseException {
		if (text == null) {
			return null;
		}
		
		return DATE_FORMAT_KOREAN.parse(text);
	}
	
	// 결제내역 버전
	private static SimpleDateFormat DATE_FORMAT_ORDER_TIME = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 날짜를 전달받아서 "2024-01-04 13:52:08"과 같은 형식의 문자열로 반환한다.
	 * @param date 날짜
	 * @return 형식화된 문자열
	 */
	public static String toTextOrderTime(Date date) {
		if (date == null) {
			return "";
		}
		
		return DATE_FORMAT_ORDER_TIME.format(date);
		
	}
	
	public static Date toDateOrderTime(String text) throws ParseException {
		if (text == null) {
			return null;
		}
		
		return DATE_FORMAT_ORDER_TIME.parse(text);
	}
	
	/**
     * 날짜를 전달받아서 "2월 11일"과 같은 형식의 문자열로 반환한다.
     * @param date 날짜
     * @return 형식화된 문자열
     */
    public static String toTextMonthDay(Date date) {
        if (date == null) {
            return "";
        }
        
        return DATE_FORMAT_MONTH_DAY.format(date);
    }
    /**
     * 날짜를 전달받아서 "yyyy.MM.dd HH:mm" 형식의 문자열로 반환한다.
     * @param date 날짜
     * @return 형식화된 문자열
     */
    public static String toTextCustom(Date date) {
        if (date == null) {
            return "";
        }
        
        return DATE_FORMAT_CUSTOM.format(date);
    }
}
