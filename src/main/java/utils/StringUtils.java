package utils;

public class StringUtils {

	/**
	 * 지정된 텍스트의 줄바꿈문자를 br 태그로 변경한 텍스트를 반환한다.
	 * @param text 텍스트
	 * @return 줄바꿈문자 br 태그로 변경된 문자열
	 */
	public static String withBr(String text) {
		if (text == null) {
			return "";
		}
		return text.replace(System.lineSeparator(), "<br>");
	}
	
	/**
	 * 지정된 텍스트의 특수문자를 특수문자로 인식되게 변경하여 반환한다.
	 * @param text 텍스트
	 * @return 변경한 텍스트
	 */
	public static String escape(String text) {
		if (text == null) {
			return null;
		}
		return text.replace("\\", "\\\\")
		          .replace("\t", "\\t")
		          .replace("\b", "\\b")
		          .replace("\n", "\\n")
		          .replace("\r", "\\r")
		          .replace("\f", "\\f")
		          .replace("\'", "\\'")      // <== not necessary
		          .replace("\"", "\\\"");
	}
}
