#include "datainitialization.h"
#include <QSettings>
#include <QDir>
#include <QDebug>
#include <QFile>
DataInitialization::DataInitialization(QObject *parent)
    : QObject{parent}
{
}
