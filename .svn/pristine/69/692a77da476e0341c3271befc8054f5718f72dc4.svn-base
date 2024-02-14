package utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {

	private static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy년 M월 d일");
	
	/**
	 * 날짜를 전달받아서 "2024년 1월 4일"과 같은 형식의 문자열로 반환한다.
	 * @param date 날짜
	 * @return 형식화된 문자열
	 */
	public static String toText(Date date) {
		if (date == null) {
			return "";
		}
		
		return DATE_FORMAT.format(date);
	
	}
}
