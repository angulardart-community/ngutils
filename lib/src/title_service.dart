import 'dart:html';

class TitleService {
	String getTitle() {
		return document.title;
	}

	void setTitle(String newTitle) {
		document.title = newTitle ?? '';
	}
}