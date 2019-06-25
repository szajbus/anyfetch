# Anyfetch Changelog

## 0.1.5

* Replace `cocaine` dependency with `terrapin` (the gem was renamed).

## 0.1.4

* Don't URI-encode FTP usernames

## 0.1.3

* Remove automating URI-encoding altogether as it probably should not be responsibility of the library.
* Always return `Tempfile` from HTTP and FTP handlers.

## 0.1.2

* Prepare URI for parsing by decoding and re-encoding

## 0.1.1

* Use old hash notation to support ruby 1.8

## 0.1

Initial release
