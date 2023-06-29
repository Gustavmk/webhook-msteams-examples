$URI = 'webhook connection'

# @type - Must be set to `MessageCard`.
# @context - Must be set to [`https://schema.org/extensions`](<https://schema.org/extensions>).
# title - The title of the card, usually used to announce the card.
# text - The card's purpose and what it may be describing.
# activityTitle - The title of the section, such as "Test Section", displayed in bold.
# activitySubtitle - A descriptive subtitle underneath the title.
# activityText - A longer description that is usually used to describe more relevant data.

$JSON = @{
  "@type"    = "MessageCard"
  "@context" = "<http://schema.org/extensions>"
  "title"    = 'Test Card Title'
  "text"     = 'Typically used to describe the purpose of the card.'
  "sections" = @(
    @{
      "activityTitle"    = 'Test Section'
      "activitySubtitle" = 'Section Subtitle'
      "activityText"     = 'Descriptive text for the activity.'
    }
  )
} | ConvertTo-JSON

# You will always be sending content in via POST and using the ContentType of 'application/json'
# The URI will be the URL that you previously retrieved when creating the webhook
$Params = @{
  "URI"         = $URI
  "Method"      = 'POST'
  "Body"        = $JSON
  "ContentType" = 'application/json'
}

Invoke-RestMethod @Params