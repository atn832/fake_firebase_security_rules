grammar FirestoreRules;
rulesDefinition: rulesVersion? service* EOF;
rulesVersion: 'rules_version' '=' STRING;
service: 'service' serviceName=('cloud.firestore' | 'firebase.storage') '{' matcher* '}';
matcher: 'match' path '{' (allow|matcher)* '}';
allow: 'allow' METHOD (',' METHOD)* CEL;

METHOD: 'read' | 'write' | 'get' | 'list' | 'create' | 'update' | 'delete';
path: pathSegment+;
pathSegment: '/' (NAME|variable);
NAME: [a-zA-Z0-9_-]+;
variable: '{' NAME wildcard='=**'? '}';
STRING: '\'' .*? '\'';
CEL: (':' 'if'? .*?)? ';';

WHITESPACE: (' ' | '\t' | '\r' | '\n')+ -> skip;
COMMENT: '//' (~'\n')* -> skip;
