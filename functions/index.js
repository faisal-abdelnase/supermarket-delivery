const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.paymobWebhook = functions.https.onRequest(async (req, res) => {
    try {
    const data = req.body;

    // Paymob sends many event types
    if (data.type !== "TRANSACTION") {
        return res.sendStatus(200);
    }

    const transaction = data.obj;
    const orderId = transaction.order.id.toString();

    let status = "failed";

    if (transaction.success === true) {
        status = "success";
    } else if (transaction.pending === true) {
        status = "pending";
    }

    await admin.firestore()
        .collection("orders")
        .doc(orderId)
        .update({
        status: status,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

    console.log(`Order ${orderId} updated to ${status}`);

    return res.sendStatus(200);
    } catch (error) {
    console.error("Webhook Error:", error);
    return res.sendStatus(500);
    }
});
