import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    visible: true
    width: 360
    height: 360

    ListView {
        id: listView
        anchors.fill: parent
        model: 40
        highlightFollowsCurrentItem: true

        delegate: SlideLeftToDeleteDelegate {
            id: itemContent
            width: listView.width
            height: 50

            Text {
                text: qsTr("Index ") + index
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
                listView.currentItem.hideDeleteButton(true)
                listView.currentIndex = index
            }

            onDeleteButtonShown: {
                listView.currentItem.hideDeleteButton(true)
                listView.currentIndex = index
            }
        }
    }
}
