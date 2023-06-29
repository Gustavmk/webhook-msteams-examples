$URI = 'webhook connection'

# @type - Must be set to `MessageCard`.
# @context - Must be set to [`https://schema.org/extensions`](<https://schema.org/extensions>).
# title - The title of the card, usually used to announce the card.
# text - The card's purpose and what it may be describing.
# activityTitle - The title of the section, such as "Test Section", displayed in bold.
# activitySubtitle - A descriptive subtitle underneath the title.
# activityText - A longer description that is usually used to describe more relevant data.

# Azure DevOps YAML Pipeline Variables Set
$url_pipeline = $(Build.BuildUri)
$url_repository = $(Build.Repository.Uri)
$project_name = $(System.TeamProject)
$status = $(Agent.JobStatus)
# 

# TEST LOCAL
#$url_pipeline = "https://dev.azure.com/devops-microvix/DevOps/_build/results?buildId=40311&view=logs&j=12f1170f-54f2-53f3-20dd-22fc7dff55f9&t=76467409-274e-589c-5c88-4286504c504b"
#$url_repository = "https://dev.azure.com/devops-microvix/DevOps/_git/EnvBuilder"
#$project_name = "DevOps"
#$status = "sucess"


$JSONBody = [PSCustomObject][Ordered]@{
    "@type" = "MessageCard"
    "@context" = "<http://schema.org/extensions>"
    "themeColor" = '0078D7'
    "title" = "Azure DevOps Pipeline"
    "text" = " <br>
              <strong>Team Project:</strong> $($project_name) <br>
              <b>DefinitionName:</b> $($Build.DefinitionName) <br>
              Repo: <a href=${url_repository}>Link to Repository</a> <br>
              Pipeline: <a href=${url_pipeline}>Link to Pipeline</a> <br>
    <br>
      <b>Status:</b>                  $($status) <br>
    <br>
    Greetings, <br>
    Mr.DevOps"

}
$TeamMessageBody = ConvertTo-Json $JSONBody  -Depth 100

# You will always be sending content in via POST and using the ContentType of 'application/json'
# The URI will be the URL that you previously retrieved when creating the webhook
$Params = @{
  "URI"         = $URI
  "Method"      = 'POST'
  "Body"        = $TeamMessageBody
  "ContentType" = 'application/json'
}

Invoke-RestMethod @Params