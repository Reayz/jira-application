using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;
using static Dapper.SqlMapper;

namespace JiraApplication.DBContexts
{
    public class DapperDBContext : IDapperDBContext
    {

        private readonly IDbConnection db;
        private readonly IConfiguration config;
        private string Connectionstring = "Key1";

        public DapperDBContext(IConfiguration _config)
        {
            config = _config;
            db = new SqlConnection(config.GetConnectionString(Connectionstring));
        }

        public SqlConnection getDBConnection()
        {
            return (SqlConnection)db;
        }

        public ResponseObjectType GetInfo<ResponseObjectType>(object obj, string sp)
        {
            var result = db.QueryFirstOrDefault<ResponseObjectType>(sp, obj, commandType: CommandType.StoredProcedure);
            return result;
        }

        public async Task<ResponseObjectType> GetInfoAsync<ResponseObjectType>(object obj, string sp)
        {
            var result = await db.QueryFirstOrDefaultAsync<ResponseObjectType>(sp, obj, commandType: CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<ResponseObjectType> GetInfoList<ResponseObjectType>(object obj, string sp)
        {
            var result = db.Query<ResponseObjectType>(sp, obj, commandType: CommandType.StoredProcedure);
            return result;
        }

        public async Task<IEnumerable<ResponseObjectType>> GetInfoListAsync<ResponseObjectType>(object obj, string sp)
        {
            var result = await db.QueryAsync<ResponseObjectType>(sp, obj, commandType: CommandType.StoredProcedure);
            return result;
        }
    }
}
