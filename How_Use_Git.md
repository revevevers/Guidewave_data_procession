# git👍

[CSDN博客_《关于Git这一篇就够了》](https://blog.csdn.net/bjbz_cxy/article/details/116703787?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522e5b2f2d9a218f25b8788506dfd042626%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=e5b2f2d9a218f25b8788506dfd042626&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_positive~default-1-116703787-null-null.142^v101^pc_search_result_base3&utm_term=git&spm=1018.2226.3001.4187)

- **git常用命令**
    
    
    | 初始化仓库 | `git init` |
    | --- | --- |
    
    | 克隆仓库 | `git clone <url>` |
    | --- | --- |
    
    | 将项目文件添加到Git仓库 | `git add .` |
    | --- | --- |
    
    | 查看状态 | `git status` |
    | --- | --- |
    
    | 添加文件 | `git add <file>` |
    | --- | --- |
    
    | 提交更改 | `git commit -m "message"` |
    | --- | --- |
    
    | 查看历史 | `git log` |
    | --- | --- |
    
    | 推送更改 | `git push origin <branch>` |
    | --- | --- |
    
    | 拉取更新 | `git pull origin <branch>` |
    | --- | --- |
    
    | 创建分支 | `git branch <branch-name>` |
    | --- | --- |
    
    | 切换分支 | `git checkout <branch-name>` |
    | --- | --- |
    
    | 合并分支 | `git merge <branch-name>` |
    | --- | --- |
    
    | 删除分支 | `git branch -d <branch-name>` |
    | --- | --- |

- **本地创建仓库后连接远程仓库、创建本地分支**
    1. 在终端中导航到你想要创建git仓库的目录
        
        ```bash
        git init
        git branch -m master main
        # 这里注意最好把主分支的名称master重命名为main，因为远程仓库中默认是main。
        # 如果之前提交过旧名称的分支，可以用以下命令删除远程旧分支
        git push origin --delete master
        ```
        
    2. 将你的本地仓库连接到 GitHub 上的远程仓库
        
        ```bash
        # 使用HTTP连接
        git remote add origin https://github.com/your-username/my-project.git
        # 这是使用HTTP连接，我一般使用SSH连接。
        # 如果HTTP连接失败可尝试SSH方法，如何配置SSH密钥请自己查询。
        ```
        
        ```bash
        # 在本地添加你的SSH到远程仓库
        # （如果你之前创建过HTTP就先把它移除git remote remove origin）
        # 验证是否添加成功git remote -v
        git remote remove origin
        git remote set-url origin [git@github.com](mailto:git@github.com):revevevers/Guidewave_data_procession.git
        git remote -v
        ```
        
    3. 使用以下命令创建一个新的分支（一般在主分支以外的分支进行代码编写）
        
        ```bash
        git checkout -b new-branch-name
        
        # 切换到目标分支
        git checkout your_branch
        # 查看当前分支状态
        git status
        # 查看分支日志（包括之前的提交信息）
        git log
        ```
        
- **在某个分支中进行提交**
    1. 首先保证所有文件都被tracked，如果有文件untracked，需要先提交<file>或者<files\>
    
        ```bash
        git add <file> 或者 git add <files\>
        ```
    
    2. 确定所有文件都被跟踪后
    
        ```bash
        git commit -a -m "message"
        ```
    
- **合并本地分支**
    1. **切换到想要merge into的分支**：例如，首先，切换到主分支（例如 `main` 或 `master`）。
        
        ```bash
        git checkout main
        
        ```
        
    2. **合并分支**：然后，将你工作的分支合并到主分支。
        
        ```bash
        git merge your-feature-branch
        
        ```
        
    3. **解决冲突**：如果有冲突，解决冲突并提交合并结果。
        
        ```bash
        git commit -m ""
        ```
        
    4. **推送到远程仓库**：如果你有远程仓库，可以将合并后的主分支推送到远程仓库。
        
        ```bash
        git push origin main/zyt
        
        # 这里只写git push会报错。
        
        ```
        
- **提交本地分支到远程仓库**
    1. 获取远程仓库分支的最新信息（并不下载到本地）
        
        ```bash
        git fetch
        git branch -r # 查看所有分支
        ```
        
    2. 拉取远程分支的最新更改，并自动进行合并，如有冲突需手动解决并提交。
        
        ```bash
        git pull origin your_branch
        # 如果有冲突
        git add <冲突文件>
        git commit -a -m ""
        ```
        
    3. 成功提交合并结果后，推送本地分支到远程仓库。
        
        ```bash
        git push origin your_branch
        ```
        
- **克隆远程仓库的某个分支到本地**
    
    ```bash
    git fetch
    git pull origin branch_youwant
    git commit -a -m ""
    ```
    

- **可能存在的疑问？**
    - 频繁提交并不会占用过多内存，Git使用增量存储的方式。
    - 如果不小心提交了一个大型文件，即使你在目录中删除，Git的历史中可能仍保留着这个大型文件的记录，这会导致仓库过大无法进行推送，可以使用如下命令清除大文件。
        
        ```bash
        pip install git-filter-repo # 安装git filter-repo
        git filter-repo --path <文件名称> --invert-paths # 删除大文件
        git push origin --force # 强制推送更改
        
        # 由于更改历史记录可能导致一些权限问题，遇到问题自己查吧。。
        ```