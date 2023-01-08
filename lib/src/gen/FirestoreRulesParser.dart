// Generated from FirestoreRules.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'FirestoreRulesListener.dart';
import 'FirestoreRulesBaseListener.dart';
const int RULE_rulesDefinition = 0, RULE_rulesVersion = 1, RULE_service = 2, 
          RULE_matcher = 3, RULE_allow = 4, RULE_path = 5, RULE_pathSegment = 6, 
          RULE_variable = 7;
class FirestoreRulesParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.11.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, 
                   TOKEN_T__4 = 5, TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, 
                   TOKEN_T__8 = 9, TOKEN_T__9 = 10, TOKEN_T__10 = 11, TOKEN_T__11 = 12, 
                   TOKEN_METHOD = 13, TOKEN_NAME = 14, TOKEN_STRING = 15, 
                   TOKEN_CEL = 16, TOKEN_WHITESPACE = 17, TOKEN_COMMENT = 18;

  @override
  final List<String> ruleNames = [
    'rulesDefinition', 'rulesVersion', 'service', 'matcher', 'allow', 'path', 
    'pathSegment', 'variable'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "'rules_version'", "'='", "'service'", "'cloud.firestore'", 
      "'firebase.storage'", "'{'", "'}'", "'match'", "'allow'", "','", "'/'", 
      "'=**'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, null, null, null, null, null, 
      null, null, "METHOD", "NAME", "STRING", "CEL", "WHITESPACE", "COMMENT"
  ];
  static final Vocabulary VOCABULARY = VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'FirestoreRules.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
   return _ATN;
  }

  FirestoreRulesParser(TokenStream input) : super(input) {
    interpreter = ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  RulesDefinitionContext rulesDefinition() {
    dynamic _localctx = RulesDefinitionContext(context, state);
    enterRule(_localctx, 0, RULE_rulesDefinition);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 17;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__0) {
        state = 16;
        rulesVersion();
      }

      state = 22;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__2) {
        state = 19;
        service();
        state = 24;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 25;
      match(TOKEN_EOF);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  RulesVersionContext rulesVersion() {
    dynamic _localctx = RulesVersionContext(context, state);
    enterRule(_localctx, 2, RULE_rulesVersion);
    try {
      enterOuterAlt(_localctx, 1);
      state = 27;
      match(TOKEN_T__0);
      state = 28;
      match(TOKEN_T__1);
      state = 29;
      match(TOKEN_STRING);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ServiceContext service() {
    dynamic _localctx = ServiceContext(context, state);
    enterRule(_localctx, 4, RULE_service);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 31;
      match(TOKEN_T__2);
      state = 32;
      _localctx.serviceName = tokenStream.LT(1);
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_T__3 || _la == TOKEN_T__4)) {
        _localctx.serviceName = errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 33;
      match(TOKEN_T__5);
      state = 37;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__7) {
        state = 34;
        matcher();
        state = 39;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 40;
      match(TOKEN_T__6);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  MatcherContext matcher() {
    dynamic _localctx = MatcherContext(context, state);
    enterRule(_localctx, 6, RULE_matcher);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 42;
      match(TOKEN_T__7);
      state = 43;
      path();
      state = 44;
      match(TOKEN_T__5);
      state = 49;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__7 || _la == TOKEN_T__8) {
        state = 47;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
        case TOKEN_T__8:
          state = 45;
          allow();
          break;
        case TOKEN_T__7:
          state = 46;
          matcher();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 51;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 52;
      match(TOKEN_T__6);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  AllowContext allow() {
    dynamic _localctx = AllowContext(context, state);
    enterRule(_localctx, 8, RULE_allow);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 54;
      match(TOKEN_T__8);
      state = 55;
      match(TOKEN_METHOD);
      state = 60;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__9) {
        state = 56;
        match(TOKEN_T__9);
        state = 57;
        match(TOKEN_METHOD);
        state = 62;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 63;
      match(TOKEN_CEL);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  PathContext path() {
    dynamic _localctx = PathContext(context, state);
    enterRule(_localctx, 10, RULE_path);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 66; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 65;
        pathSegment();
        state = 68; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__10);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  PathSegmentContext pathSegment() {
    dynamic _localctx = PathSegmentContext(context, state);
    enterRule(_localctx, 12, RULE_pathSegment);
    try {
      enterOuterAlt(_localctx, 1);
      state = 70;
      match(TOKEN_T__10);
      state = 73;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_NAME:
        state = 71;
        match(TOKEN_NAME);
        break;
      case TOKEN_T__5:
        state = 72;
        variable();
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  VariableContext variable() {
    dynamic _localctx = VariableContext(context, state);
    enterRule(_localctx, 14, RULE_variable);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 75;
      match(TOKEN_T__5);
      state = 76;
      match(TOKEN_NAME);
      state = 78;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__11) {
        state = 77;
        _localctx.wildcard = match(TOKEN_T__11);
      }

      state = 80;
      match(TOKEN_T__6);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  static const List<int> _serializedATN = [
      4,1,18,83,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,1,0,3,0,18,8,0,1,0,5,0,21,8,0,10,0,12,0,24,9,0,1,0,1,0,1,1,
      1,1,1,1,1,1,1,2,1,2,1,2,1,2,5,2,36,8,2,10,2,12,2,39,9,2,1,2,1,2,1,
      3,1,3,1,3,1,3,1,3,5,3,48,8,3,10,3,12,3,51,9,3,1,3,1,3,1,4,1,4,1,4,
      1,4,5,4,59,8,4,10,4,12,4,62,9,4,1,4,1,4,1,5,4,5,67,8,5,11,5,12,5,68,
      1,6,1,6,1,6,3,6,74,8,6,1,7,1,7,1,7,3,7,79,8,7,1,7,1,7,1,7,0,0,8,0,
      2,4,6,8,10,12,14,0,1,1,0,4,5,83,0,17,1,0,0,0,2,27,1,0,0,0,4,31,1,0,
      0,0,6,42,1,0,0,0,8,54,1,0,0,0,10,66,1,0,0,0,12,70,1,0,0,0,14,75,1,
      0,0,0,16,18,3,2,1,0,17,16,1,0,0,0,17,18,1,0,0,0,18,22,1,0,0,0,19,21,
      3,4,2,0,20,19,1,0,0,0,21,24,1,0,0,0,22,20,1,0,0,0,22,23,1,0,0,0,23,
      25,1,0,0,0,24,22,1,0,0,0,25,26,5,0,0,1,26,1,1,0,0,0,27,28,5,1,0,0,
      28,29,5,2,0,0,29,30,5,15,0,0,30,3,1,0,0,0,31,32,5,3,0,0,32,33,7,0,
      0,0,33,37,5,6,0,0,34,36,3,6,3,0,35,34,1,0,0,0,36,39,1,0,0,0,37,35,
      1,0,0,0,37,38,1,0,0,0,38,40,1,0,0,0,39,37,1,0,0,0,40,41,5,7,0,0,41,
      5,1,0,0,0,42,43,5,8,0,0,43,44,3,10,5,0,44,49,5,6,0,0,45,48,3,8,4,0,
      46,48,3,6,3,0,47,45,1,0,0,0,47,46,1,0,0,0,48,51,1,0,0,0,49,47,1,0,
      0,0,49,50,1,0,0,0,50,52,1,0,0,0,51,49,1,0,0,0,52,53,5,7,0,0,53,7,1,
      0,0,0,54,55,5,9,0,0,55,60,5,13,0,0,56,57,5,10,0,0,57,59,5,13,0,0,58,
      56,1,0,0,0,59,62,1,0,0,0,60,58,1,0,0,0,60,61,1,0,0,0,61,63,1,0,0,0,
      62,60,1,0,0,0,63,64,5,16,0,0,64,9,1,0,0,0,65,67,3,12,6,0,66,65,1,0,
      0,0,67,68,1,0,0,0,68,66,1,0,0,0,68,69,1,0,0,0,69,11,1,0,0,0,70,73,
      5,11,0,0,71,74,5,14,0,0,72,74,3,14,7,0,73,71,1,0,0,0,73,72,1,0,0,0,
      74,13,1,0,0,0,75,76,5,6,0,0,76,78,5,14,0,0,77,79,5,12,0,0,78,77,1,
      0,0,0,78,79,1,0,0,0,79,80,1,0,0,0,80,81,5,7,0,0,81,15,1,0,0,0,9,17,
      22,37,47,49,60,68,73,78
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}
class RulesDefinitionContext extends ParserRuleContext {
  TerminalNode? EOF() => getToken(FirestoreRulesParser.TOKEN_EOF, 0);
  RulesVersionContext? rulesVersion() => getRuleContext<RulesVersionContext>(0);
  List<ServiceContext> services() => getRuleContexts<ServiceContext>();
  ServiceContext? service(int i) => getRuleContext<ServiceContext>(i);
  RulesDefinitionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_rulesDefinition;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterRulesDefinition(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitRulesDefinition(this);
  }
}

class RulesVersionContext extends ParserRuleContext {
  TerminalNode? STRING() => getToken(FirestoreRulesParser.TOKEN_STRING, 0);
  RulesVersionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_rulesVersion;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterRulesVersion(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitRulesVersion(this);
  }
}

class ServiceContext extends ParserRuleContext {
  Token? serviceName;
  List<MatcherContext> matchers() => getRuleContexts<MatcherContext>();
  MatcherContext? matcher(int i) => getRuleContext<MatcherContext>(i);
  ServiceContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_service;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterService(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitService(this);
  }
}

class MatcherContext extends ParserRuleContext {
  PathContext? path() => getRuleContext<PathContext>(0);
  List<AllowContext> allows() => getRuleContexts<AllowContext>();
  AllowContext? allow(int i) => getRuleContext<AllowContext>(i);
  List<MatcherContext> matchers() => getRuleContexts<MatcherContext>();
  MatcherContext? matcher(int i) => getRuleContext<MatcherContext>(i);
  MatcherContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_matcher;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterMatcher(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitMatcher(this);
  }
}

class AllowContext extends ParserRuleContext {
  List<TerminalNode> METHODs() => getTokens(FirestoreRulesParser.TOKEN_METHOD);
  TerminalNode? METHOD(int i) => getToken(FirestoreRulesParser.TOKEN_METHOD, i);
  TerminalNode? CEL() => getToken(FirestoreRulesParser.TOKEN_CEL, 0);
  AllowContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_allow;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterAllow(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitAllow(this);
  }
}

class PathContext extends ParserRuleContext {
  List<PathSegmentContext> pathSegments() => getRuleContexts<PathSegmentContext>();
  PathSegmentContext? pathSegment(int i) => getRuleContext<PathSegmentContext>(i);
  PathContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_path;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterPath(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitPath(this);
  }
}

class PathSegmentContext extends ParserRuleContext {
  TerminalNode? NAME() => getToken(FirestoreRulesParser.TOKEN_NAME, 0);
  VariableContext? variable() => getRuleContext<VariableContext>(0);
  PathSegmentContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_pathSegment;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterPathSegment(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitPathSegment(this);
  }
}

class VariableContext extends ParserRuleContext {
  Token? wildcard;
  TerminalNode? NAME() => getToken(FirestoreRulesParser.TOKEN_NAME, 0);
  VariableContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_variable;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterVariable(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitVariable(this);
  }
}

