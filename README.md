# home_work_4

Homework № 4

## Порядок рішення

Не зміг розібратися з нативною частиною (поки не достатньо знань та часу).
Використав плагін device_info_plus: ^8.0.0 та приклад до нього.

Переробив (провів експерименти) як можна передавати Обєкти замість Мар.
Переробив спосіб виведення інформації в ListView, розібрався як це працює.
Спробував порефакторити частини коду.

В звязку з перебоями зі світлом не вистачає часу на детальну роботу над домашкою.

Є функції однотипні, наприклад:

List<ParameterItem> _readAndroidBuildData(AndroidDeviceInfo data) {
List<ParameterItem> pi = <ParameterItem>[];

    data.toMap().forEach((key, value) {
      pi.add(ParameterItem(key.toString(), value));
    });

    return pi;
}

List<ParameterItem> _readIosDeviceInfo(IosDeviceInfo data) {
List<ParameterItem> pi = <ParameterItem>[];

    data.toMap().forEach((key, value) {
      pi.add(ParameterItem(key.toString(), value));
    });

    return pi;
}

List<ParameterItem> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
List<ParameterItem> pi = <ParameterItem>[];

    data.toMap().forEach((key, value) {
      pi.add(ParameterItem(key.toString(), value));
    });

    return pi;
}

Не вийшло в мене щось з всіх зробити одну, щоб приймала необхідний тип даних data на вході
Щось по типу
List<ParameterItem> _readAndroidBuildData(<T> data) {
постійно якісь помилки

