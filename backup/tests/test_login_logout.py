from pyramid import testing
from mock import Mock

from ..models.user import User
from . import DatabaseTestCase
from ..views.user import (
        register_submission,
        )


class TestLoginLogout(DatabaseTestCase):

    def set_up(self):
        print(self.db_session.query(User).all())
        request = testing.DummyRequest()
        request.db_session = self.db_session
        request.route_url = Mock()
        u1=User('user1@gmail.com', 'user1_pass')
        self.u1=u1
        request.db_session.add_all([u1])
        request.db_session.commit()
        self.request=request

    def tear_down(self):
        pass

    def test_user_register(self):
        self.request.POST={
                'email': self.u1.email,
                'password': self.u1.password,
            }
        response=register_submission(self.request)
        print(response)
        
