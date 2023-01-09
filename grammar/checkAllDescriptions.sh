echo 1
antlr4-parse FirestoreRules.g4 rulesDefinition -tree 1_sample_rules_version.txt
echo 
echo 2
antlr4-parse FirestoreRules.g4 rulesDefinition -tree 2_service.txt
echo 
echo 3
antlr4-parse FirestoreRules.g4 rulesDefinition -tree 3_empty_match.txt
echo 
echo 4
antlr4-parse FirestoreRules.g4 rulesDefinition -tree 4_match.txt
echo 
echo 5
antlr4-parse FirestoreRules.g4 rulesDefinition -tree 5_recursive_wildcard.txt
echo 
echo 6
antlr4-parse FirestoreRules.g4 rulesDefinition -tree 6_single_read_write.txt
echo 
echo 7
antlr4-parse FirestoreRules.g4 rulesDefinition -tree 7_request.auth.uid.txt
echo 
echo 8
antlr4-parse FirestoreRules.g4 rulesDefinition -tree 8_complete_partial_matches.txt
echo 
echo 9
antlr4-parse FirestoreRules.g4 rulesDefinition -tree -tokens 9_custom_claims.txt
