grammar FirestoreRules;
rulesDefinition: rulesVersion? service? EOF;
rulesVersion: 'rules_version' '=' STRING;
service: 'service' 'cloud.firestore' '{' matcher* '}';
matcher: 'match' path '{' (allow|matcher)* '}';
allow: 'allow' METHOD (',' METHOD)* ':' CES_EXPRESSION;

METHOD: 'read' | 'write' | 'get' | 'list' | 'create' | 'update' | 'delete';
path: pathSegment+;
pathSegment: '/' (NAME|variable);
NAME: [a-zA-Z0-9_-]+;
variable: '{' NAME '=**'? '}';
STRING: '\'' .*? '\'';
CES_EXPRESSION: 'if' (~'\n')+ | ('true'|'false') ';';

WHITESPACE: (' ' | '\t' | '\r' | '\n')+ -> skip;
COMMENT: '//' (~'\n')* -> skip;
