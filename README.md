# GitHub Assets Branch

This branch is dedicated to storing assets (such as images, icons, and other static files) for use in online projects. The assets can be accessed via GitHub's Content Delivery Network (CDN), allowing seamless integration into applications and websites.

## Usage

You can use the assets hosted in this branch by referencing them through GitHub's raw content URL. The general format for accessing files is:

```
https://cdn.jsdelivr.net/gh/user/repo@version/file
```

### Example
If you have an image named `logo.png` stored in a folder called `images`, you can access it using:

```
https://cdn.jsdelivr.net/gh/hamidwaezi/notched_card@cdn/assets/top.png

```

Replace `<user>`, `<repo>`, and `<version or branch>` with the appropriate values from your GitHub repository.

## Best Practices
- Store only necessary assets to keep the branch lightweight.
- Use meaningful filenames and folder structures.
- Avoid storing sensitive information in this branch.
