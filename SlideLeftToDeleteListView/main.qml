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
