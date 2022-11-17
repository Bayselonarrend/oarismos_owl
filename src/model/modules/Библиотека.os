#Использовать sql

Процедура Тест_Должен_ПроверитьГенерациюСтрокиСоединения() Экспорт
	
	Соединение = Новый Соединение();
	Соединение.ТипСУБД = Соединение.ТипыСУБД.MySQL;
	Соединение.Сервер = "localhost";
	Соединение.ИмяПользователя = "root";
	Соединение.ИмяБазы = "oarismos_main";
	Соединение.Пароль = "Rit258910";
	Соединение.Порт = 3306;

	Попытка
		/// Заведомо известно падение при открытии.
		/// Строка соединения генерируется только при открытии
		Соединение.Открыть();
	Исключение
		Ожидаем.Что(Соединение.СтрокаСоединения).Равно("server=localhost;user=root;password=Rit258910;database=oarismos_main;port=3306;");
	КонецПопытки;

КонецПроцедуры

Процедура Тест_Должен_ДолженПолучитьВыборку() Экспорт

	Соединение = Новый Соединение();
	Соединение.ТипСУБД = Соединение.ТипыСУБД.MySQL;
	Соединение.СтрокаСоединения = мСтрокаСоединения;
	Соединение.Открыть();

	ЗапросВставка = Новый Запрос();
	ЗапросВставка.УстановитьСоединение(Соединение);

	ЗапросВставка.Текст = "DROP TABLE IF EXISTS users";
	ЗапросВставка.ВыполнитьКоманду();

	ЗапросВставка.Текст = "Create table users (id integer, name varchar(50))";
	ЗапросВставка.ВыполнитьКоманду();

	ЗапросВставка.Текст = "insert into users (name) values(@name)";
	ЗапросВставка.УстановитьПараметр("name", "Сергей");
	ЗапросВставка.ВыполнитьКоманду();

	ЗапросВставка.Параметры.Очистить();
	ЗапросВставка.Текст = "select * from users";
	ТЗ = ЗапросВставка.Выполнить().Выгрузить();

	Ожидаем.Что(ТЗ.Количество()).Равно(1);

	Соединение.Закрыть();

КонецПроцедуры