#include <QObject>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QtWebEngine>
#include <QFileDialog>

int main(int argc, char *argv[])
{
	QApplication app(argc, argv);

#if defined(Q_OS_MACX)
	QCoreApplication::addLibraryPath(QCoreApplication::applicationDirPath() + "/../PlugIns");
#endif

	QQmlApplicationEngine engine;
	QString qmlPath;

	qmlPath = QString("qrc:/tests/test.qml");

	QObject::connect(&engine, SIGNAL(quit()), QCoreApplication::instance(), SLOT(quit()));

	// Initializing WebEngine and WebView
	QtWebEngine::initialize(); 

	// Run it
	engine.load(QUrl(qmlPath));
	if (engine.rootObjects().isEmpty())
		return -1;

	return app.exec();
}
