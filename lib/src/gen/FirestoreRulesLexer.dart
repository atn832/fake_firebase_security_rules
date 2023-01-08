// Generated from FirestoreRules.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';


class FirestoreRulesLexer extends Lexer {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.11.1', RuntimeMetaData.VERSION);

  static final List<DFA> _decisionToDFA = List.generate(
        _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int
    TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, TOKEN_T__4 = 5, 
    TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, TOKEN_T__8 = 9, TOKEN_T__9 = 10, 
    TOKEN_T__10 = 11, TOKEN_T__11 = 12, TOKEN_METHOD = 13, TOKEN_NAME = 14, 
    TOKEN_STRING = 15, TOKEN_CEL = 16, TOKEN_WHITESPACE = 17, TOKEN_COMMENT = 18;
  @override
  final List<String> channelNames = [
    'DEFAULT_TOKEN_CHANNEL', 'HIDDEN'
  ];

  @override
  final List<String> modeNames = [
    'DEFAULT_MODE'
  ];

  @override
  final List<String> ruleNames = [
    'T__0', 'T__1', 'T__2', 'T__3', 'T__4', 'T__5', 'T__6', 'T__7', 'T__8', 
    'T__9', 'T__10', 'T__11', 'METHOD', 'NAME', 'STRING', 'CEL', 'WHITESPACE', 
    'COMMENT'
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


  FirestoreRulesLexer(CharStream input) : super(input) {
    interpreter = LexerATNSimulator(_ATN, _decisionToDFA, _sharedContextCache, recog: this);
  }

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  String get grammarFileName => 'FirestoreRules.g4';

  @override
  ATN getATN() { return _ATN; }

  static const List<int> _serializedATN = [
      4,0,18,201,6,-1,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,
      6,7,6,2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,
      13,2,14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,1,0,1,0,1,0,1,0,1,0,1,0,
      1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,2,1,2,1,2,1,2,1,2,1,2,1,
      2,1,2,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,
      1,3,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,
      4,1,4,1,5,1,5,1,6,1,6,1,7,1,7,1,7,1,7,1,7,1,7,1,8,1,8,1,8,1,8,1,8,
      1,8,1,9,1,9,1,10,1,10,1,11,1,11,1,11,1,11,1,12,1,12,1,12,1,12,1,12,
      1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,
      12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,
      1,12,1,12,3,12,153,8,12,1,13,4,13,156,8,13,11,13,12,13,157,1,14,1,
      14,5,14,162,8,14,10,14,12,14,165,9,14,1,14,1,14,1,15,1,15,1,15,3,15,
      172,8,15,1,15,5,15,175,8,15,10,15,12,15,178,9,15,3,15,180,8,15,1,15,
      1,15,1,16,4,16,185,8,16,11,16,12,16,186,1,16,1,16,1,17,1,17,1,17,1,
      17,5,17,195,8,17,10,17,12,17,198,9,17,1,17,1,17,2,163,176,0,18,1,1,
      3,2,5,3,7,4,9,5,11,6,13,7,15,8,17,9,19,10,21,11,23,12,25,13,27,14,
      29,15,31,16,33,17,35,18,1,0,3,5,0,45,45,48,57,65,90,95,95,97,122,3,
      0,9,10,13,13,32,32,1,0,10,10,213,0,1,1,0,0,0,0,3,1,0,0,0,0,5,1,0,0,
      0,0,7,1,0,0,0,0,9,1,0,0,0,0,11,1,0,0,0,0,13,1,0,0,0,0,15,1,0,0,0,0,
      17,1,0,0,0,0,19,1,0,0,0,0,21,1,0,0,0,0,23,1,0,0,0,0,25,1,0,0,0,0,27,
      1,0,0,0,0,29,1,0,0,0,0,31,1,0,0,0,0,33,1,0,0,0,0,35,1,0,0,0,1,37,1,
      0,0,0,3,51,1,0,0,0,5,53,1,0,0,0,7,61,1,0,0,0,9,77,1,0,0,0,11,94,1,
      0,0,0,13,96,1,0,0,0,15,98,1,0,0,0,17,104,1,0,0,0,19,110,1,0,0,0,21,
      112,1,0,0,0,23,114,1,0,0,0,25,152,1,0,0,0,27,155,1,0,0,0,29,159,1,
      0,0,0,31,179,1,0,0,0,33,184,1,0,0,0,35,190,1,0,0,0,37,38,5,114,0,0,
      38,39,5,117,0,0,39,40,5,108,0,0,40,41,5,101,0,0,41,42,5,115,0,0,42,
      43,5,95,0,0,43,44,5,118,0,0,44,45,5,101,0,0,45,46,5,114,0,0,46,47,
      5,115,0,0,47,48,5,105,0,0,48,49,5,111,0,0,49,50,5,110,0,0,50,2,1,0,
      0,0,51,52,5,61,0,0,52,4,1,0,0,0,53,54,5,115,0,0,54,55,5,101,0,0,55,
      56,5,114,0,0,56,57,5,118,0,0,57,58,5,105,0,0,58,59,5,99,0,0,59,60,
      5,101,0,0,60,6,1,0,0,0,61,62,5,99,0,0,62,63,5,108,0,0,63,64,5,111,
      0,0,64,65,5,117,0,0,65,66,5,100,0,0,66,67,5,46,0,0,67,68,5,102,0,0,
      68,69,5,105,0,0,69,70,5,114,0,0,70,71,5,101,0,0,71,72,5,115,0,0,72,
      73,5,116,0,0,73,74,5,111,0,0,74,75,5,114,0,0,75,76,5,101,0,0,76,8,
      1,0,0,0,77,78,5,102,0,0,78,79,5,105,0,0,79,80,5,114,0,0,80,81,5,101,
      0,0,81,82,5,98,0,0,82,83,5,97,0,0,83,84,5,115,0,0,84,85,5,101,0,0,
      85,86,5,46,0,0,86,87,5,115,0,0,87,88,5,116,0,0,88,89,5,111,0,0,89,
      90,5,114,0,0,90,91,5,97,0,0,91,92,5,103,0,0,92,93,5,101,0,0,93,10,
      1,0,0,0,94,95,5,123,0,0,95,12,1,0,0,0,96,97,5,125,0,0,97,14,1,0,0,
      0,98,99,5,109,0,0,99,100,5,97,0,0,100,101,5,116,0,0,101,102,5,99,0,
      0,102,103,5,104,0,0,103,16,1,0,0,0,104,105,5,97,0,0,105,106,5,108,
      0,0,106,107,5,108,0,0,107,108,5,111,0,0,108,109,5,119,0,0,109,18,1,
      0,0,0,110,111,5,44,0,0,111,20,1,0,0,0,112,113,5,47,0,0,113,22,1,0,
      0,0,114,115,5,61,0,0,115,116,5,42,0,0,116,117,5,42,0,0,117,24,1,0,
      0,0,118,119,5,114,0,0,119,120,5,101,0,0,120,121,5,97,0,0,121,153,5,
      100,0,0,122,123,5,119,0,0,123,124,5,114,0,0,124,125,5,105,0,0,125,
      126,5,116,0,0,126,153,5,101,0,0,127,128,5,103,0,0,128,129,5,101,0,
      0,129,153,5,116,0,0,130,131,5,108,0,0,131,132,5,105,0,0,132,133,5,
      115,0,0,133,153,5,116,0,0,134,135,5,99,0,0,135,136,5,114,0,0,136,137,
      5,101,0,0,137,138,5,97,0,0,138,139,5,116,0,0,139,153,5,101,0,0,140,
      141,5,117,0,0,141,142,5,112,0,0,142,143,5,100,0,0,143,144,5,97,0,0,
      144,145,5,116,0,0,145,153,5,101,0,0,146,147,5,100,0,0,147,148,5,101,
      0,0,148,149,5,108,0,0,149,150,5,101,0,0,150,151,5,116,0,0,151,153,
      5,101,0,0,152,118,1,0,0,0,152,122,1,0,0,0,152,127,1,0,0,0,152,130,
      1,0,0,0,152,134,1,0,0,0,152,140,1,0,0,0,152,146,1,0,0,0,153,26,1,0,
      0,0,154,156,7,0,0,0,155,154,1,0,0,0,156,157,1,0,0,0,157,155,1,0,0,
      0,157,158,1,0,0,0,158,28,1,0,0,0,159,163,5,39,0,0,160,162,9,0,0,0,
      161,160,1,0,0,0,162,165,1,0,0,0,163,164,1,0,0,0,163,161,1,0,0,0,164,
      166,1,0,0,0,165,163,1,0,0,0,166,167,5,39,0,0,167,30,1,0,0,0,168,171,
      5,58,0,0,169,170,5,105,0,0,170,172,5,102,0,0,171,169,1,0,0,0,171,172,
      1,0,0,0,172,176,1,0,0,0,173,175,9,0,0,0,174,173,1,0,0,0,175,178,1,
      0,0,0,176,177,1,0,0,0,176,174,1,0,0,0,177,180,1,0,0,0,178,176,1,0,
      0,0,179,168,1,0,0,0,179,180,1,0,0,0,180,181,1,0,0,0,181,182,5,59,0,
      0,182,32,1,0,0,0,183,185,7,1,0,0,184,183,1,0,0,0,185,186,1,0,0,0,186,
      184,1,0,0,0,186,187,1,0,0,0,187,188,1,0,0,0,188,189,6,16,0,0,189,34,
      1,0,0,0,190,191,5,47,0,0,191,192,5,47,0,0,192,196,1,0,0,0,193,195,
      8,2,0,0,194,193,1,0,0,0,195,198,1,0,0,0,196,194,1,0,0,0,196,197,1,
      0,0,0,197,199,1,0,0,0,198,196,1,0,0,0,199,200,6,17,0,0,200,36,1,0,
      0,0,9,0,152,157,163,171,176,179,186,196,1,6,0,0
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}