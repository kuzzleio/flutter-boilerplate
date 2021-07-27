// GENERATED FILE, do not edit!
import 'package:i18n/i18n.dart' as i18n;
	String get _languageCode => 'en';
	String _plural(int count, {String? zero, String? one, String? two, String?few, String? many, String? other}) =>
	i18n.plural(count, _languageCode, zero:zero, one:one, two:two, few:few, many:many, other:other);
String _ordinal(int count, {String? zero, String? one, String? two, String? few, String? many, String? other}) =>
	i18n.ordinal(count, _languageCode, zero:zero, one:one, two:two, few:few, many:many, other:other);
String _cardinal(int count, {String? zero, String? one, String? two, String? few, String? many, String? other}) =>
	i18n.cardinal(count, _languageCode, zero:zero, one:one, two:two, few:few, many:many, other:other);

class Messages {
String get locale => "en";
String get languageCode => "en";
	const Messages();
	LoginMessages get login => LoginMessages(this);
	HomeMessages get home => HomeMessages(this);
	ErrorsMessages get errors => ErrorsMessages(this);
	MenuMessages get menu => MenuMessages(this);
}

class LoginMessages {
String get locale => "en";
String get languageCode => "en";
	final Messages _parent;
	const LoginMessages(this._parent);
	String get title => """Login""";
	String get email => """Email""";
	String get password => """Password""";
	String get emailValidator => """Please enter an email""";
	String get passwordValidator => """Please enter a password""";
	String get loginButtonLabel => """Login""";
	String get rememberEmail => """Remember me""";
}

class HomeMessages {
String get locale => "en";
String get languageCode => "en";
	final Messages _parent;
	const HomeMessages(this._parent);
	String get title => """Home""";
	String get welcome => """Welcome home!""";
}

class ErrorsMessages {
String get locale => "en";
String get languageCode => "en";
	final Messages _parent;
	const ErrorsMessages(this._parent);
	String get logoutError => """Error while logging out""";
}

class MenuMessages {
String get locale => "en";
String get languageCode => "en";
	final Messages _parent;
	const MenuMessages(this._parent);
	HomeMenuMessages get home => HomeMenuMessages(this);
	MapMenuMessages get map => MapMenuMessages(this);
	NotificationMenuMessages get notification => NotificationMenuMessages(this);
	SettingsMenuMessages get settings => SettingsMenuMessages(this);
	CroissantMenuMessages get croissant => CroissantMenuMessages(this);
}

class HomeMenuMessages {
String get locale => "en";
String get languageCode => "en";
	final MenuMessages _parent;
	const HomeMenuMessages(this._parent);
	String get label => """Home""";
	String get title => """Home""";
}

class MapMenuMessages {
String get locale => "en";
String get languageCode => "en";
	final MenuMessages _parent;
	const MapMenuMessages(this._parent);
	String get label => """Map""";
	String get title => """My location""";
}

class NotificationMenuMessages {
String get locale => "en";
String get languageCode => "en";
	final MenuMessages _parent;
	const NotificationMenuMessages(this._parent);
	String get label => """Notifications""";
	String get title => """My notifications""";
}

class SettingsMenuMessages {
String get locale => "en";
String get languageCode => "en";
	final MenuMessages _parent;
	const SettingsMenuMessages(this._parent);
	String get label => """Settings""";
	String get title => """Settings""";
}

class CroissantMenuMessages {
String get locale => "en";
String get languageCode => "en";
	final MenuMessages _parent;
	const CroissantMenuMessages(this._parent);
	String get label => """Croissant""";
	String get title => """Miam""";
}


Map<String, String> get messagesMap => {
	"""login.title""": """Login""",
	"""login.email""": """Email""",
	"""login.password""": """Password""",
	"""login.emailValidator""": """Please enter an email""",
	"""login.passwordValidator""": """Please enter a password""",
	"""login.loginButtonLabel""": """Login""",
	"""login.rememberEmail""": """Remember me""",
	"""home.title""": """Home""",
	"""home.welcome""": """Welcome home!""",
	"""errors.logoutError""": """Error while logging out""",
	"""menu.home.label""": """Home""",
	"""menu.home.title""": """Home""",
	"""menu.map.label""": """Map""",
	"""menu.map.title""": """My location""",
	"""menu.notification.label""": """Notifications""",
	"""menu.notification.title""": """My notifications""",
	"""menu.settings.label""": """Settings""",
	"""menu.settings.title""": """Settings""",
	"""menu.croissant.label""": """Croissant""",
	"""menu.croissant.title""": """Miam""",
};
