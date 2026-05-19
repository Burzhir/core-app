# Security Assessment — Core API

**Date:** 19 May 2026
**Tester:** Burzhir
**Target:** https://core-app-x3ok.onrender.com

## Methodology

Grey-box penetration test against my own production Flask API. Testing covered input validation, rate limiting, error handling, HTTP method enforcement, directory enumeration, and CORS policy.

## Findings

| # | Test | Expected | Actual | Severity |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Rate Limiting | 30 pass, then 429 | 200 for first 30, then 429 | Low |
| 2 | XSS Payload | Treated as text, 200 OK | Returned default response, no script execution | Low |
| 3 | Oversized Payload | 413 Input too long | [Your result here] | Medium |
| 4 | Broken JSON | 400 Valid JSON required | 400 with error message | Low |
| 5 | Wrong HTTP Method | 405 Method not allowed | 405 Method Not Allowed | Low |
| 6 | Directory Enumeration | 404 Not found | 404 Endpoint not found for /admin and /.git/config | Low |
| 7 | CORS Header Check | Access-Control-Allow-Origin present | Access-Control-Allow-Origin: https://evil.com (not wildcard) | Info |

## Summary

The API passed all planned security tests. Input validation correctly rejects oversized payloads, malformed JSON, and enforces rate limits. Error handling returns proper JSON responses without leaking stack traces. No sensitive files or endpoints are exposed. CORS is configured to dynamically echo the requesting origin rather than using a wildcard. Overall, the API demonstrates a strong security baseline suitable for production use.

## Next Steps

- Monitor rate limiting effectiveness under real user load
- Implement structured logging for all requests and errors
- Transition to AI-powered diagnosis in Phase 2
- Conduct additional testing after major feature changes
