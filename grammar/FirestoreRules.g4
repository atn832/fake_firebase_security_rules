grammar FirestoreRules;
rulesDefinition: rulesVersion? service? EOF;
rulesVersion: 'rules_version' '=' STRING;
service: 'service' 'cloud.firestore' '{' matcher* '}';
matcher: 'match' path '{' (allow|matcher)* '}';
allow: 'allow' ACCESS (',' ACCESS)* ':' CES_EXPRESSION;

ACCESS: 'read' | 'write';
path: pathSegment+;
pathSegment: '/' (NAME|variable);
NAME: [a-zA-Z0-9_-]+;
variable: '{' NAME '=**'? '}';
STRING: '\'' .*? '\'';
CES_EXPRESSION: 'if' (~'\n')+ | ('true'|'false') ';';

WHITESPACE: (' ' | '\t' | '\r' | '\n')+ -> skip;
COMMENT: '//' (~'\n')* -> skip;
