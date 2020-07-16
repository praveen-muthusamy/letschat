const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
exports.createMessage = functions.firestore
    .document('users/{userId}')
    .onCreate((snap, context) => {
        const _message = snap.data();
        console.log(_message);

        return admin.messaging().sendToTopic('chats', {
            notification: {
                title: _message.username,
                body: _message.message,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            }
        })
    }
);