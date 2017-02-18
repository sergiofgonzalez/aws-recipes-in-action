AWS_DEFAULT_PROFILE=hackathon

AWS_USER=$(aws iam get-user --query "User.Arn" --output text)
echo "Running AWS as $AWS_USER"

aws iam create-group --group-name "aia-group"
aws iam attach-group-policy --group-name "aia-group" --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess"
aws iam create-user --user-name "aia-user"
aws iam add-user-to-group --group-name "aia-group" --user-name "aia-user"
aws iam create-login-profile --user-name "aia-group" --user-name "aia-user" --password "w4UQCbKa8PIgt"

