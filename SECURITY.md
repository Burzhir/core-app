1. Rate Limiting
Sent 35 rapid requests to verify that the first 30 were accepted (200 OK) and subsequent ones were blocked with a 429 Too Many Requests error, confirming the rate limiter is enforced.

2. Cross-Site Scripting (XSS)
Submitted a payload containing <script>alert(1)</script> to ensure the API treats it as harmless text and returns a normal JSON response; no script execution occurs because the API returns JSON, not HTML.

3. Oversized Payload
Sent a 5,000-character string to confirm the API rejects input exceeding the 2,000-character limit with a 413 error and a clear message.

4. Broken JSON
Provided malformed JSON input to check that the API returns a 400 Bad Request error along with a descriptive error message instead of crashing or leaking internal details.

5. Wrong HTTP Method
Used a GET request on the /api/diagnose endpoint (which only accepts POST) to verify it returns a 405 Method Not Allowed error.

6. Directory Enumeration
Attempted to access common sensitive paths like /admin and /.git/config; both correctly returned 404 Not Found, indicating no unintended information disclosure.

7. CORS Header
Sent a request with an Origin header set to https://evil.com and confirmed the response includes Access-Control-Allow-Origin: https://evil.com (not a wildcard *), showing the API dynamically echoes the specific origin.
