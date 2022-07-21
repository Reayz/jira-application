using Microsoft.Data.SqlClient;

namespace JiraApplication.DBContexts
{
    public interface IDapperDBContext
    {
        SqlConnection getDBConnection();
        ResponseObjectType GetInfo<ResponseObjectType>(object obj, string sp);
        Task<ResponseObjectType> GetInfoAsync<ResponseObjectType>(object obj, string sp);
        IEnumerable<ResponseObjectType> GetInfoList<ResponseObjectType>(object obj, string sp);
        Task<IEnumerable<ResponseObjectType>> GetInfoListAsync<ResponseObjectType>(object obj, string sp);
    }
}
