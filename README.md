# Noterizer 

1. User Can Login and keep track of their notes
2. User can create, update, delete
3. User is constrained to Noterizer's rules: 


Rule 1: Subject cannot be more than 30 chars 
Rule 2: Body cannot be more than 1000 chars 
Rule 3: Note cannot be entirely blank 


Technical Behavior 
1. I created input elements for the relevant table cells so they could be updated without page loads through JQuery
2. I created model validations to enforce the rules listed 
3. I tested the rules in the notes_test 


To Run: 
1. Clone Repo 
2. Bundle
3. rails db:migrate 
4. rails s




