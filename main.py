import sys
from pathlib import Path
from PySide6.QtCore import QObject, Signal, Slot
import DataBase as database
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

class Interface(QObject):
    signal = Signal()

    def __init__(self, engine):
     super().__init__()
     self.engine = engine

    @Slot()
    def creatTable(self):
       database.createTable()

    @Slot()
    def deletee(self):
        database.delete()

    @Slot(str,str,result=bool)
    def databasetocsv(self,filename,date):
        result=database.dataBasetoCsv(filename,date)
        if result :
            return True
        else:
            return False

    @Slot(str,str,str,str,result=bool)
    def insert(self,fromAddress,toAddress,subject,body):
        result=database.insert(fromAddress,toAddress,subject,body)
        if result:
            return True
        else:
            return False

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    interface = Interface(engine)
    engine.rootContext().setContextProperty("middle", interface)

    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
