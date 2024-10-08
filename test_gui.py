import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QPushButton, QVBoxLayout, QWidget
from PyQt5 import uic

class MainWindow(QMainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()
        
        # Load the UI file created with Qt Designer
        uic.loadUi("main_window.ui", self)

        # Access the initial button by its object name (from the .ui file)
        self.button1 = self.findChild(QPushButton, "button1")

        # Connect the button1 pressed signal to the custom method
        self.button1.clicked.connect(self.show_buttons)

        # Create a layout to dynamically add buttons
        self.layout = QVBoxLayout(self.centralWidget())

    def show_buttons(self):
        # Create two new buttons dynamically
        self.button2 = QPushButton("Button 2", self)
        self.button3 = QPushButton("Button 3", self)

        # Add them to the layout
        self.layout.addWidget(self.button2)
        self.layout.addWidget(self.button3)

        # Optionally, connect them to functions or add further logic
        self.button2.clicked.connect(lambda: print("Button 2 clicked"))
        self.button3.clicked.connect(lambda: print("Button 3 clicked"))


# Boilerplate to run the application
if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
