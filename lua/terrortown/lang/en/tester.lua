L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[TESTER.name] = "Tester"
L["info_popup_" .. TESTER.name] = [[You are the Tester!
If If one of your Traitor colleagues dies, your HP increases by a certain value.]]
L["body_found_" .. TESTER.abbr] = "They were a Tester."
L["search_role_" .. TESTER.abbr] = "This person was a Tester!"
L["target_" .. TESTER.name] = "Tester"
L["ttt2_desc_" .. TESTER.name] = [[The Tester needs to win with the traitors!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_tester_epop"] = "While some lose strength, others gain new strength!"