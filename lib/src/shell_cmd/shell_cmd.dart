// Copyright (c) 2017, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dart_analyser_client.shell_cmd;

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import '../config.dart';
import '../dart_adapter_base.dart';

class AdapterShellCmd {
  final AnalyzerConfig config;

  Process _process;

  StreamSubscription<String> _inStreamSub;

  AdapterShellCmd(this.config);

  bool get isRunning => _process != null;

  Future<Null> start() async {
    if (isRunning) {
      throw new Exception("Analyzer already running!");
    }
    _process = await _createProcess(config);
    _inStreamSub = _process.stdout
        .transform(UTF8.encoder)
        .transform(new LineSplitter())
        .listen(_processInMsg);
    //TODO connect writer
  }

  /// Restarts, or starts, the analysis server process.
  Future<Null> restart() async {
    if (isRunning) {
      await kill();
    }

    await start();
  }

  Future<Null> kill() async {
    if (isRunning) {
      _process.kill();
      _process = null;
      if (_inStreamSub is StreamSubscription) _inStreamSub.cancel();
      //TODO listener for when process terminates
    }
  }

  void _processInMsg(String msg) {
    //TODO
  }

  static Future<Process> _createProcess(AnalyzerConfig config) {
    List<String> arguments = <String>[];

    if (config.useChecked) {
      arguments.add('--checked');
    }

    if (config.startWithDiagnostics) {
      arguments.add('--enable-vm-service=0');
    }

    arguments.add(config.getAnalysisServerSnapshotPath());

    arguments.add('--sdk=${config.sdkPath}');

    // Check to see if we should start with diagnostics enabled.
    if (config.startWithDiagnostics) {
      arguments.add('--port=${AnalyzerConfig.diagnosticsPort}');
    }

    arguments.add('--client-id=icu');

    return Process.start(config.dartVMPath, arguments);
  }


  /**
   * Analyze the given Dart source code and return any resulting analysis errors
   * or warnings.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [AnalysisResults].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AnalysisResults> analyze(SourceRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'analyze';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new AnalysisResults.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [source] - Query parameter: 'source'.
   *
   * [strongMode] - Query parameter: 'strongMode'.
   *
   * Completes with a [AnalysisResults].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AnalysisResults> analyzeGet({core.String source, core.bool strongMode}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (strongMode != null) {
      _queryParams["strongMode"] = ["${strongMode}"];
    }

    _url = 'analyze';

    var _response = _requester.request(_url,
        "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new AnalysisResults.fromJson(data));
  }

  /**
   * Analyze the given Dart source code and return any resulting analysis errors
   * or warnings.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [AnalysisResults].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AnalysisResults> analyzeMulti(SourcesRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'analyzeMulti';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new AnalysisResults.fromJson(data));
  }

  /**
   * Compile the given Dart source code and return the resulting JavaScript.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [CompileResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CompileResponse> compile(CompileRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'compile';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new CompileResponse.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [source] - Query parameter: 'source'.
   *
   * Completes with a [CompileResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CompileResponse> compileGet({core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'compile';

    var _response = _requester.request(_url,
        "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new CompileResponse.fromJson(data));
  }

  /**
   * Get the valid code completion results for the given offset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [CompleteResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CompleteResponse> complete(SourceRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'complete';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new CompleteResponse.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [source] - Query parameter: 'source'.
   *
   * [offset] - Query parameter: 'offset'.
   *
   * Completes with a [CompleteResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CompleteResponse> completeGet({core.String source, core.int offset}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (offset != null) {
      _queryParams["offset"] = ["${offset}"];
    }

    _url = 'complete';

    var _response = _requester.request(_url,
        "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new CompleteResponse.fromJson(data));
  }

  /**
   * Get the valid code completion results for the given offset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [CompleteResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CompleteResponse> completeMulti(SourcesRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'completeMulti';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new CompleteResponse.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [name] - Query parameter: 'name'.
   *
   * Completes with a [CounterResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CounterResponse> counterGet({core.String name}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name != null) {
      _queryParams["name"] = [name];
    }

    _url = 'counter';

    var _response = _requester.request(_url,
        "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new CounterResponse.fromJson(data));
  }

  /**
   * Return the relevant dartdoc information for the element at the given
   * offset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [DocumentResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DocumentResponse> document(SourceRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'document';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new DocumentResponse.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [source] - Query parameter: 'source'.
   *
   * [offset] - Query parameter: 'offset'.
   *
   * Completes with a [DocumentResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DocumentResponse> documentGet({core.String source, core.int offset}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (offset != null) {
      _queryParams["offset"] = ["${offset}"];
    }

    _url = 'document';

    var _response = _requester.request(_url,
        "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new DocumentResponse.fromJson(data));
  }

  /**
   * Get any quick fixes for the given source code location.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [FixesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FixesResponse> fixes(SourceRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'fixes';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new FixesResponse.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [source] - Query parameter: 'source'.
   *
   * [offset] - Query parameter: 'offset'.
   *
   * Completes with a [FixesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FixesResponse> fixesGet({core.String source, core.int offset}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (offset != null) {
      _queryParams["offset"] = ["${offset}"];
    }

    _url = 'fixes';

    var _response = _requester.request(_url,
        "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new FixesResponse.fromJson(data));
  }

  /**
   * Get any quick fixes for the given source code location.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [FixesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FixesResponse> fixesMulti(SourcesRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'fixesMulti';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new FixesResponse.fromJson(data));
  }

  /**
   * Format the given Dart source code and return the results. If an offset is
   * supplied in the request, the new position for that offset in the formatted
   * code will be returned.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [FormatResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FormatResponse> format(SourceRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'format';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new FormatResponse.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * [source] - Query parameter: 'source'.
   *
   * [offset] - Query parameter: 'offset'.
   *
   * Completes with a [FormatResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FormatResponse> formatGet({core.String source, core.int offset}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (offset != null) {
      _queryParams["offset"] = ["${offset}"];
    }

    _url = 'format';

    var _response = _requester.request(_url,
        "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new FormatResponse.fromJson(data));
  }

  /**
   * Summarize the given Dart source code and return any resulting analysis
   * errors or warnings.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SummaryText].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SummaryText> summarize(SourcesRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'summarize';

    var _response = _requester.request(_url,
        "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new SummaryText.fromJson(data));
  }

  /**
   * Return the current SDK version for DartServices.
   *
   * Request parameters:
   *
   * Completes with a [VersionResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VersionResponse> version() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'version';

    var _response = _requester.request(_url,
        "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new VersionResponse.fromJson(data));
  }
}