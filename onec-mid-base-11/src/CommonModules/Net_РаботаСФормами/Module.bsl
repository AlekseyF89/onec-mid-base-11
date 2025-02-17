#Область ПрограммныйИнтерфейс

Процедура ДополнитьФорму (Форма) Экспорт
    //{Фролов Проверка Форм и дальнейшая передача форм на добавление элементов
	ИмяФормы = Форма.ИмяФормы;
	
	Если ИмяФормы = "Документ.ЗаказПокупателя.Форма.ФормаДокумента" Тогда
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма);
		ДобавитьПолеСкидкаВГруппаШапкаЛево(Форма);
	ИначеЕсли ИмяФормы = "Документ.ПоступлениеТоваровУслуг.Форма.ФормаДокумента" Тогда
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма);
	ИначеЕсли ИмяФормы = "Документ.РеализацияТоваровУслуг.Форма.ФормаДокумента" Тогда
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма); 
	ИначеЕсли ИмяФормы = "Документ.ОплатаОтПокупателя.Форма.ФормаДокумента" Тогда
		ВставитьПолеКонтактноеЛицоНаФормуПередОснование(Форма);
	ИначеЕсли ИмяФормы = "Документ.ОплатаПоставщику.Форма.ФормаДокумента" Тогда
		ВставитьПолеКонтактноеЛицоНаФормуПередСуммаДокумента(Форма); 
	КонецЕсли;
	//Фролов Проверка Форм и дальнейшая передача форм на добавление элементов}
КонецПроцедуры  

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма)
	
	//{Фролов Добавим поле КонтактноеЛицо
    ПолеВвода = Форма.Элементы.Добавить("КонтактноеЛицо", Тип("ПолеФормы"), Форма.Элементы.ГруппаШапкаПраво);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.Net_КонтактноеЛицо";
	//Фролов Добавим поле КонтактноеЛицо}
КонецПроцедуры 

Процедура ДобавитьПолеСкидкаВГруппаШапкаЛево(Форма)
	
	//{Фролов Создание обычной группы без отображения
	ГруппаСогласованнаяСкидкаПересчитать = Форма.Элементы.Добавить("ГруппаОбычная", Тип("ГруппаФормы"),Форма.Элементы.ГруппаШапкаЛево);
	ГруппаСогласованнаяСкидкаПересчитать.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаСогласованнаяСкидкаПересчитать.Отображение = ОтображениеОбычнойГруппы.Нет;
	ГруппаСогласованнаяСкидкаПересчитать.ОтображатьЗаголовок = ЛОЖЬ; 
	ГруппаСогласованнаяСкидкаПересчитать.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	
	//Фролов Добавим поле СогласованнаяСкидка
	ПолеВвода = Форма.Элементы.Добавить("СогласованнаяСкидка", Тип("ПолеФормы"), ГруппаСогласованнаяСкидкаПересчитать);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.Net_СогласованнаяСкидка";
	ПолеВвода.УстановитьДействие("ПриИзменении","Net_СогласованнаяСкидкаПриИзменении");
	
	//Фролов Добавим команду в коллекцию команд
	КомандаПересчитать = Форма.Команды.Добавить("ПересчитатьТаблицу");
	КомандаПересчитать.Заголовок = "Пересчитать Таблицу";
	КомандаПересчитать.Действие = "Net_КомандаПересчитатьТаблицу";
	
	КнопкаКоманды = Форма.Элементы.Добавить("ПересчитатьТаблицу", Тип("КнопкаФормы"), ГруппаСогласованнаяСкидкаПересчитать);
	КнопкаКоманды.ИмяКоманды = "ПересчитатьТаблицу";
	КнопкаКоманды.Картинка = БиблиотекаКартинок.Перечитать;
	КнопкаКоманды.Отображение = ОтображениеКнопки.КартинкаИТекст;
	// Если помещаем просто на форму, то вид - обычная кнопка
	// Если укажем контейнер с типом Командная панель, то вид - КнопкаКоманднойПанели
	КнопкаКоманды.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
    //Фролов}
КонецПроцедуры

Процедура ВставитьПолеКонтактноеЛицоНаФормуПередСуммаДокумента(Форма)
	
	//{Фролов Вставляем поле КонтактноеЛицо
	ПолеВвода = Форма.Элементы.Вставить("КонтактноеЛицо", Тип("ПолеФормы"),, Форма.Элементы.СуммаДокумента);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.Net_КонтактноеЛицо";
    //Фролов Вставляем поле КонтактноеЛицо}
КонецПроцедуры

Процедура ВставитьПолеКонтактноеЛицоНаФормуПередОснование(Форма)
	
	//{Фролов Вставляем поле КонтактноеЛицо
	ПолеВвода = Форма.Элементы.Вставить("КонтактноеЛицо", Тип("ПолеФормы"),, Форма.Элементы.Основание);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.Net_КонтактноеЛицо";
    //Фролов Вставляем поле КонтактноеЛицо}
КонецПроцедуры

#КонецОбласти