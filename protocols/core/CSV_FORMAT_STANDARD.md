# CSV FORMAT STANDARD
Version: 1.0.0

## Purpose

Define the canonical CSV format for QA test case import into Google Sheets and Jira/Zephyr.

---

## Delimiter

Primary delimiter: ~

Reason: Avoid collision with commas in test data or API payloads.

---

## Structure

Title~<value>~~
Objective~<value>~~
Preconditions~<value>~~
~~~
ID~Step~Test Data~Expected Result

---

## Rules

- Use triple ~~~ separators between tests.
- No extra whitespace.
- No embedded tilde characters in content.
- Preserve step order.
- Maintain deterministic expected results.

---

## Import Procedure

1. Upload CSV to Google Sheets.
2. Select delimiter = Custom.
3. Enter "~".
4. Validate column alignment.

---

End of Document
