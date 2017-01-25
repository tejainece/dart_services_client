// Copyright (c) 2017, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dart_analyser_client.http;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../../dart_adapter_base.dart';
import '../../models/models.dart';

part 'client.dart';

class AdapterHttp implements Adapter {
  final AnalyzerConfig config;

  final Client _client;

  AdapterHttp(this.config, String url): _client = new Client(baseUrl: url) {
  }

  bool get isRunning => true;

  Future<Null> start() async {}

  Future<Null> restart() async {}

  Future<Null> kill() async {}

  @override
  Future<AnalysisResults> analyze(SourceRequest request) async {
    final String body = JSON.encode((request).toJson());

    final String myPath = 'analyze';

    http.Response resp = await _client.post(myPath, body: body);

    return new AnalysisResults.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<AnalysisResults> analyzeGet({String source, bool strongMode}) async {
    final String myPath = 'analyze';
    final queryParams = <String, String>{};

    if (source != null) {
      queryParams["source"] = [source];
    }
    if (strongMode != null) {
      queryParams["strongMode"] = ["$strongMode"];
    }

    http.Response resp = await _client.get(myPath, queryParams: queryParams);

    return new AnalysisResults.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<AnalysisResults> analyzeMulti(SourcesRequest request) async {
    final String body = JSON.encode((request).toJson());

    final String myPath = 'analyzeMulti';

    http.Response resp = await _client.post(myPath, body: body);

    return new AnalysisResults.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<CompileResponse> compile(CompileRequest request) async {
    final String body = JSON.encode((request).toJson());

    final String myPath = 'compile';

    http.Response resp = await _client.post(myPath, body: body);

    return new CompileResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<CompileResponse> compileGet({String source}) async {
    final queryParams = <String, String>{};

    if (source != null) {
      queryParams["source"] = [source];
    }

    final String myPath = 'compile';

    http.Response resp = await _client.get(myPath, queryParams: queryParams);

    return new CompileResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<CompleteResponse> complete(SourceRequest request) async {
    final String body = JSON.encode((request).toJson());

    final String myPath = 'complete';

    http.Response resp = await _client.post(myPath, body: body);

    return new CompleteResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<CompleteResponse> completeGet({String source, int offset}) async {
    final queryParams = <String, String>{};

    if (source != null) {
      queryParams["source"] = [source];
    }
    if (offset != null) {
      queryParams["offset"] = ["$offset"];
    }

    final String myPath = 'complete';

    http.Response resp = await _client.get(myPath, queryParams: queryParams);

    return new CompleteResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<CompleteResponse> completeMulti(SourcesRequest request) async {
    final String body = JSON.encode((request).toJson());

    final String myPath = 'completeMulti';

    http.Response resp = await _client.post(myPath, body: body);

    return new CompleteResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<CounterResponse> counterGet({String name}) async {
    final queryParams = <String, String>{};

    if (name != null) {
      queryParams["name"] = [name];
    }

    final String myPath = 'counter';

    http.Response resp = await _client.get(myPath, queryParams: queryParams);

    return new CounterResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<DocumentResponse> document(SourceRequest request) async {
    final String body = JSON.encode((request).toJson());

    final String myPath = 'document';

    http.Response resp = await _client.post(myPath, body: body);

    return new DocumentResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<DocumentResponse> documentGet({String source, int offset}) async {
    final queryParams = <String, String>{};

    if (source != null) {
      queryParams["source"] = [source];
    }
    if (offset != null) {
      queryParams["offset"] = ["$offset"];
    }

    final String myPath = 'document';

    http.Response resp = await _client.get(myPath, queryParams: queryParams);

    return new DocumentResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<FixesResponse> fixes(SourceRequest request) async {
    final String body = JSON.encode((request).toJson());

    final String myPath = 'fixes';

    http.Response resp = await _client.post(myPath, body: body);

    return new FixesResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<FixesResponse> fixesGet({String source, int offset}) async {
    final queryParams = <String, String>{};

    if (source != null) {
      queryParams["source"] = [source];
    }
    if (offset != null) {
      queryParams["offset"] = ["$offset"];
    }

    final String myPath = 'fixes';

    http.Response resp = await _client.get(myPath, queryParams: queryParams);

    return new FixesResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<FixesResponse> fixesMulti(SourcesRequest request) async {
    final String body = JSON.encode((request).toJson());

    final String myPath = 'fixesMulti';

    http.Response resp = await _client.post(myPath, body: body);

    return new FixesResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<FormatResponse> format(SourceRequest request) async {
    final String body = JSON.encode((request).toJson());

    final String myPath = 'format';

    http.Response resp = await _client.post(myPath, body: body);

    return new FormatResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<FormatResponse> formatGet({String source, int offset}) async {
    final queryParams = <String, String>{};
    if (source != null) {
      queryParams["source"] = [source];
    }
    if (offset != null) {
      queryParams["offset"] = ["$offset"];
    }
    final String myPath = 'format';
    http.Response resp = await _client.get(myPath, queryParams: queryParams);

    return new FormatResponse.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<SummaryText> summarize(SourcesRequest request) async {
    final String body = JSON.encode((request).toJson());
    final String myPath = 'summarize';
    http.Response resp = await _client.post(myPath, body: body);

    return new SummaryText.fromJson(JSON.decode(resp.body));
  }

  @override
  Future<VersionResponse> version() async {
    final String myPath = 'version';
    http.Response resp = await _client.get(myPath);

    return new VersionResponse.fromJson(JSON.decode(resp.body));
  }
}