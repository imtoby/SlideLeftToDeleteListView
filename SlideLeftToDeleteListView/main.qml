import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    visible: true
    width: 360
    height: 360

    ListView {
        id: listView
        anchors.fill: parent
        model: testModel

        highlightFollowsCurrentItem: true

        delegate: SlideLeftToDeleteDelegate {
            id: itemContent
            width: listView.width
            height: 50

            Text {
                text: name + " " + value
                anchors.centerIn: parent
                color: listView.currentIndex == index ? "red" : ""
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "gray"
                anchors.bottom: parent.bottom
            }

            Rectangle {
                width: 100
                height: 40
                color: testMouseArea.pressed ? "#E86688" : "#80E86688"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 9

                Text {
                    anchors.centerIn: parent
                    text: "a button"
                }

                MouseArea {
                    id: testMouseArea
                    anchors.fill: parent
                }
            }

            onContentRectangleClicked: {
                // TODO something
                console.log(mouse.x, mouse.y)
            }

            onDeleteButtonClicked: {
                testModel.remove(index)
            }
        }
    }

    ListModel {
        id: testModel
    }

    Component.onCompleted: {
        // test data
        for (var i=0; i<100; ++i) {
            testModel.append({"name": "test", "value": i})
        }
    }
}
