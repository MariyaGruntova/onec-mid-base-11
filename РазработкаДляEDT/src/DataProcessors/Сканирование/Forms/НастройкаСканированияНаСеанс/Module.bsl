///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Разрешение = Параметры.Разрешение;
	Цветность = Параметры.Цветность;
	Поворот = Параметры.Поворот;
	РазмерБумаги = Параметры.РазмерБумаги;
	ДвустороннееСканирование = Параметры.ДвустороннееСканирование;
	ИспользоватьImageMagickДляПреобразованияВPDF = Параметры.ИспользоватьImageMagickДляПреобразованияВPDF;
	ПоказыватьДиалогСканера = Параметры.ПоказыватьДиалогСканера;
	ФорматСканированногоИзображения = Параметры.ФорматСканированногоИзображения;
	КачествоJPG = Параметры.КачествоJPG;
	СжатиеTIFF = Параметры.СжатиеTIFF;
	СохранятьВPDF = Параметры.СохранятьВPDF;
	ФорматХраненияМногостраничный = Параметры.ФорматХраненияМногостраничный;
	
	Элементы.Поворот.Доступность = Параметры.ДоступностьПоворот;
	Элементы.РазмерБумаги.Доступность = Параметры.ДоступностьРазмерБумаги;
	Элементы.ДвустороннееСканирование.Доступность = Параметры.ДоступностьДвустороннееСканирование;
	
	ФорматJPG = Перечисления.ФорматыСканированногоИзображения.JPG;
	ФорматTIF = Перечисления.ФорматыСканированногоИзображения.TIF;
	
	Элементы.ГруппаКачествоJPG.Видимость = (ФорматСканированногоИзображения = ФорматJPG);
	Элементы.СжатиеTIFF.Видимость = (ФорматСканированногоИзображения = ФорматTIF);
	
	Элементы.КачествоJPG.Заголовок = СтрШаблон(НСтр("ru='Качество (%1)'"), КачествоJPG);
	УстановитьПодсказки();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбработатьИспользованиеДиалогаСканирования();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФорматСканированногоИзображенияПриИзменении(Элемент)
	
	Элементы.ГруппаКачествоJPG.Видимость = (ФорматСканированногоИзображения = ФорматJPG);
	Элементы.СжатиеTIFF.Видимость = (ФорматСканированногоИзображения = ФорматTIF);
	УстановитьПодсказки();
	
КонецПроцедуры

&НаКлиенте
Процедура КачествоJPGПриИзменении(Элемент)
	Элементы.КачествоJPG.Заголовок = СтрШаблон(НСтр("ru='Качество (%1)'"), КачествоJPG);
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьДиалогСканераПриИзменении(Элемент)
	ОбработатьИспользованиеДиалогаСканирования();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ОчиститьСообщения();
	Если Не ПроверитьЗаполнение() Тогда 
		Возврат;
	КонецЕсли;
	
	РезультатВыбора = Новый Структура;
	РезультатВыбора.Вставить("ПоказыватьДиалогСканера",  ПоказыватьДиалогСканера);
	РезультатВыбора.Вставить("Разрешение",               Разрешение);
	РезультатВыбора.Вставить("Цветность",                Цветность);
	РезультатВыбора.Вставить("Поворот",                  Поворот);
	РезультатВыбора.Вставить("РазмерБумаги",             РазмерБумаги);
	РезультатВыбора.Вставить("ДвустороннееСканирование", ДвустороннееСканирование);
	
	РезультатВыбора.Вставить("ИспользоватьImageMagickДляПреобразованияВPDF",
		ИспользоватьImageMagickДляПреобразованияВPDF);
	
	РезультатВыбора.Вставить("ФорматСканированногоИзображения", ФорматСканированногоИзображения);
	РезультатВыбора.Вставить("КачествоJPG",                     КачествоJPG);
	РезультатВыбора.Вставить("СжатиеTIFF",                      СжатиеTIFF);
	РезультатВыбора.Вставить("СохранятьВPDF",                   СохранятьВPDF);
	РезультатВыбора.Вставить("ФорматХраненияМногостраничный",   ФорматХраненияМногостраничный);
	
	ФорматХраненияОдностраничный = ПреобразоватьФорматСканированияВФорматХранения(ФорматСканированногоИзображения, СохранятьВPDF);
	РезультатВыбора.Вставить("ФорматХраненияОдностраничный",    ФорматХраненияОдностраничный);
	
	ОповеститьОВыборе(РезультатВыбора);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ПреобразоватьФорматСканированияВФорматХранения(ФорматСканирования, СохранятьВPDF)
	
	Возврат РаботаСФайламиСлужебный.ПреобразоватьФорматСканированияВФорматХранения(ФорматСканирования, СохранятьВPDF); 
	
КонецФункции

&НаСервере
Процедура УстановитьПодсказки()
	
	ПодсказкаФормата = "";
	РасширеннаяПодсказка = Строка(Элементы.СохранятьВPDF.РасширеннаяПодсказка.Заголовок); 
	Подсказки = СтрРазделить(РасширеннаяПодсказка, Символы.ПС);
	ТекущийФормат = Строка(ФорматСканированногоИзображения);
	Для Каждого Подсказка Из Подсказки Цикл
		Если СтрНачинаетсяС(Подсказка, ТекущийФормат) Тогда
			 ПодсказкаФормата = Подсказка;
		КонецЕсли;
	КонецЦикла;
	
	Элементы.ОписаниеФорматаОдностраничногоДокумента.Заголовок = ПодсказкаФормата;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьИспользованиеДиалогаСканирования()
	
	Элементы.Разрешение.Доступность = Не ПоказыватьДиалогСканера;
	Элементы.Цветность.Доступность = Не ПоказыватьДиалогСканера;
	Элементы.Поворот.Доступность = Не ПоказыватьДиалогСканера;
	Элементы.РазмерБумаги.Доступность = Не ПоказыватьДиалогСканера;
	Элементы.ДвустороннееСканирование.Доступность = Не ПоказыватьДиалогСканера;
	Элементы.ФорматСканированногоИзображения.Доступность = Не ПоказыватьДиалогСканера;
	Элементы.КачествоJPG.Доступность = Не ПоказыватьДиалогСканера;
	Элементы.СжатиеTIFF.Доступность = Не ПоказыватьДиалогСканера;

КонецПроцедуры

#КонецОбласти
