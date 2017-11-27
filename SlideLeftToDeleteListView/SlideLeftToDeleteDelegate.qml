import QtQuick 2.3

Item {
    width: parent.width
    height: 50

    property int deleteButtonWidth: 100
    property int hideOrShowAnimationDuration: 200
    property int slidingDistanceTriggerChangeState: 5

    signal deleteButtonClicked()
    signal deleteButtonHidden()
    signal deleteButtonShown()

    signal contentRectangleClicked()
    // you can add other signal(s) here

    function hideDeleteButton(withAnimation) {
        if (withAnimation) {
            contentRect.state = "hidden"
        } else {
            contentRect.x = 0
        }
    }

    function showDeleteButton(withAnimation) {
        if (withAnimation) {
            contentRect.state = "shown"
        } else {
            contentRect.x = 0 - deleteButton.width
        }
    }

    Rectangle {
        id: deleteButton
        width: parent.deleteButtonWidth
        height: parent.height
        color: "red"
        anchors.right: parent.right
        opacity: deleteButtonMouseArea.pressed ? 0.5 :
                                                 Math.max((0 - contentRect.x) / deleteButton.width, 0.4)

        Text {
            text: qsTr("DELETE")
            anchors.centerIn: parent
            color: "white"
            font.pointSize: 14
        }

        MouseArea {
            id: deleteButtonMouseArea
            anchors.fill: parent
            onClicked: {
                deleteButtonClicked()
            }
        }
    }

    Rectangle {
        id: contentRect
        width: parent.width
        height: parent.height
        state: "hidden"

        onStateChanged: {
            if ("hidden" == state) {
                deleteButtonHidden()
            } else if ("shown" == state) {
                deleteButtonShown()
            }
        }

        states: [
            State {
                name: "hidden"
                PropertyChanges { target: contentRect; x: 0 }
            },State {
                name: "shown"
                PropertyChanges { target: contentRect; x: 0 - deleteButton.width }
            }
        ]

        transitions: Transition {
            NumberAnimation { properties: "x"; duration: hideOrShowAnimationDuration }
        }

        MouseArea {
            anchors.fill: parent
            drag.target: contentRect
            drag.axis: Drag.XAxis
            drag.minimumX: - deleteButton.width
            drag.maximumX: 0

            readonly property bool draging: drag.active
            onDragingChanged: {
                if (!draging) {
                    if (contentRect.state == "hidden") {
                        if (contentRect.x < (0-slidingDistanceTriggerChangeState)) {
                            contentRect.state = "shown"
                        } else {
                            contentRect.state = ""
                            contentRect.state = "hidden"
                        }
                    } else if (contentRect.state == "shown") {
                        if (contentRect.x >
                                (slidingDistanceTriggerChangeState - deleteButton.width)) {
                            contentRect.state = "hidden"
                        } else {
                            contentRect.state = ""
                            contentRect.state = "shown"
                        }
                    }
                }
            }

            onClicked: {
                contentRectangleClicked()
            }
        }
    }

}
