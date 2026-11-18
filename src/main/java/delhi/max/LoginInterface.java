package delhi.max;

import org.springframework.data.repository.CrudRepository;

public interface LoginInterface extends CrudRepository<LoginDTO, String>{
	LoginDTO getLoginDTOByUid(String uid);
}
