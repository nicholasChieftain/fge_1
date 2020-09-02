# Курсовая работа по дисциплине ТИИ за 1 семестр

## Структура алгоритма

Скелет алгоритма - конечный автомат. Конечный автомат был выбран из-за удобства отладки и редактирования структуры кода: добавления новых функций, изменения контейнеров хранения данных и т.п..

### Состояния конечного автомата:
1. Инициализация переменных/ввод данных
2. Создание исходной орбиты/элипса
3. Создание шаблона fis со случаными весовыми коэффициентами
4. Создание шаблонов fis для координат x и y со случайными весовыми коэффициентами
5. Расчет координат x и y после вылета с орбиты
6. Расчет воздействия нечеткого регулятора на результ воздействия
7. Сортировка наборов весовых коэффициентов по велчине ошибке работы регулятора
8. Создание нового набора/поколения коэффициентов для нечеткого регулятора