// ignore_for_file: constant_identifier_names

const baseURL =
    'http://192.168.1.4:8000/api'; // 192.168.1.2 accordding to ip config in your pc

// admin
const getUserUrl = '$baseURL/admin/getAlluser';
const logoutAdmintUrl = '$baseURL/admin/logout_admin';
const loginAdminURL = '$baseURL/login_admin';
const getAnotherUserURL = '$baseURL/admin/Anotheruser';
const banUserURL = '$baseURL/admin/ban_user';
const unbanUserURL = '$baseURL/admin/unban_user';
const DeleteUserURL = '$baseURL/admin/delete_user';
const DeletePostURL = '$baseURL/admin/delete_post_from_admin';
const getPostAdminURL = '$baseURL/admin/post';
// craftsman and patron posts   
const searchPostURL = '$baseURL/search_post';
const getPostURL = '$baseURL/post';   //  visitor
const getPostsURL = '$baseURL/posts';    // auth patrong or craftsaman
const createPostURL = '$baseURL/post/create';
const updatePostURL = '$baseURL/post/update';
const deletePostURL = '$baseURL/post/delete';


// craftsman and patron users

const getAnotherUser = '$baseURL/Anotheruser';
const loginURL = '$baseURL/login_user';
const registerURL = '$baseURL/register_user';
const logoutUrl = '$baseURL/logout_user';
const userURL = '$baseURL/user';
const modifyUserURL = '$baseURL/update_user';
const modifyPasswordURL = '$baseURL/update_password';

const serverError = 'Server Error';
