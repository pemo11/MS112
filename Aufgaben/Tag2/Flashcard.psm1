class Flashcard
{
    [String]$Id
    [String]$Title
    [String]$Description

    Flashcard([String]$id, [String]$title, [String]$description)
    {
        $this.Id = $id
        $this.Title = $title
        $this.Description = $description
    }
}