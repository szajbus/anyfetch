# Anyfetch

Anyfetch provides abstraction layer around multiple protocols to allow accessing files in uniform way.

Current support:

* local files (via path or `file:///` protocol)
* HTTP(s)
* FTP
* SFTP

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'anyfetch'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install anyfetch

## Usage

Simply provide file's URI. Optionally an `options` hash can be provided as second argument, it will be passed "as is" to specific handler (see below).

`Anyfetch.open(uri, options)`

### Local files

Both path and `file://` protocol are accepted.

```
Anyfetch.open("/path/to/file")
Anyfetch.open("file:///path/to/file")
```

### HTTP/HTTPS, FTP and SFTP

Internally `open-uri` (with extensions provided by `open_uri_redirections` gem) is used to fetch the file from HTTP and FTP servers. Feel free to pass any options recognized by `open-uri` or `open_uri_redirections`.

```
Anyfetch.open("http://example.org/file.html")
Anyfetch.open("https://user:password@example.org/file.html", { 'User-Agent' => '...' })
Anyfetch.open("ftp://user:password@example.org/file.html")
```

For SFTP, `net-ssh` is used under the hood, user and password can be provided as part of the URI or as options. Other methods of authentication are not supported yet.

```
Anyfetch.open("sftp://user:password@example.org/file.html")
Anyfetch.open("sftp://example.org/file.html", user: "user", password: "password")
```

### Original filenames

It is not always possible to know the original filename and/or content type of the accessed file upfront, e.g. when fetching files from the URLs like `http://example.org/file?id=123` or when the file is streamed from the server. Anyfetch provides `original_filename` method to the file instance to handle this. Internally it checks `content-disposition` meta information returned by the server, file's content type or simply file's basename for local files. This method can also be handy when trying to assign the file to an uploader like Paperclip or Carrierwave.

```
file = Anyfetch.open("http://example.org/file?id=123")
file.original_filename
# => filename.html
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

Found a bug? File an issue on Github. Got a patch? Submit a pull request.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/szajbus/anyfetch.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
