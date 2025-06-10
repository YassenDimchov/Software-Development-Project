# User Acceptance Testing (UAT) Scenarios

## ✅ Scenario 1: Register a new user

**Steps:**

1. Open the app and go to the Register page.
2. Fill in Name, Email, and Password.
3. Choose a profile picture.
4. Press "Register".

**Expected Result:**

- User is created in Firebase Authentication.
- Profile image is saved in Firebase Storage.
- User document is created in Firestore.

---

## ✅ Scenario 2: Send a message to another user

**Steps:**

1. Login as user A.
2. Go to Users page.
3. Select user B and start a chat.
4. Send a message.

**Expected Result:**

- A chat is created if one doesn’t exist.
- Message is saved in Firestore under chat ID.
- Message appears instantly in the chat screen.

---

## ✅ Scenario 3: Search and select users for group chat

**Steps:**

1. Login and open Users page.
2. Use the search bar to find multiple users.
3. Select two or more users.
4. Tap “Create Group Chat”.

**Expected Result:**

- A new chat is created with selected members.
- Group appears on the Chats page.
