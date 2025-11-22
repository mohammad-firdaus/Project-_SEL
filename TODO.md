# TODO for Customer Order History Page Enhancement

- [ ] Convert CustomerOrderHistoryPage to StatefulWidget to manage order updates.
- [ ] Extend Order class to store optional rating and feedback fields.
- [ ] Update OrderStatus enum to only have preparing, shipped, received.
- [ ] Modify OrderCard to:
  - Show "Mark as Received" button if order status is shipped.
  - On button press, show rating and feedback input dialog.
  - On submit, update order status to received and save feedback & rating.
  - Display rating and feedback summary for received orders.
- [ ] Remove references to 'actionRequired' status in code.
- [ ] Test the updated page for correct behavior and UI.
