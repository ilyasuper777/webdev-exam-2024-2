from flask_login import current_user
class UsersPolicy:
    def __init__(self, record):
        self.record = record

    def create_book(self):
       return current_user.is_admin() # только админ может создать книгу
    
    def delete_book(self): # только админ может удалить книгу
        return current_user.is_admin()

    def edit_book(self): # минимум модератор может редактировать книгу
        return current_user.is_admin() or current_user.is_moderator()
    
    def view_book(self): # все могут смотреть книгу
        return True
    
    def create_review(self): # все могут создавать рецензии
        return True
    
    def moderate_review(self): # минимум модератор может модерировать рецензиями
        return current_user.is_admin() or current_user.is_moderator()
    
    def view_reviews(self): # все могут смотреть рецензии
        return True
    
    
    