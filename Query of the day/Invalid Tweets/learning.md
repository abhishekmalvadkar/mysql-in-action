### Example: Difference Between `CHAR_LENGTH` and `LENGTH`

#### Table: Strings

| id | text    |
|----|---------|
| 1  | Hello   |
| 2  | Привет  |
| 3  | 你好     |

#### SQL Query:

```sql
SELECT 
    text, 
    CHAR_LENGTH(text) AS char_length, 
    LENGTH(text) AS length
FROM Strings;
```

Explanation:
Text "Hello":

Each character is 1 byte (ASCII).

CHAR_LENGTH = 5 (number of characters).

LENGTH = 5 (number of bytes).

Text "Привет" (Cyrillic):

Each character is multi-byte (UTF-8).

CHAR_LENGTH = 6 (number of characters).

LENGTH = 12 (number of bytes, as each character uses 2 bytes in UTF-8).

Text "你好" (Chinese):

Each character is multi-byte (UTF-8).

CHAR_LENGTH = 2 (number of characters).

LENGTH = 6 (number of bytes, as each character uses 3 bytes in UTF-8).

### Example Output:

| text    | char_length | length |
|---------|-------------|--------|
| Hello   | 5           | 5      |
| Привет  | 6           | 12     |
| 你好     | 2           | 6      |



Summary:

Use CHAR_LENGTH when you need the number of characters, irrespective of their byte size.

Use LENGTH when you need the number of bytes, useful for storage or data transfer calculations.









